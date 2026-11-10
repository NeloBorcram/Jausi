locals {
  repository = "${var.github_owner}/${var.github_repository}"
  environments = {
    devtest = {
      scope = azurerm_linux_web_app.web["devtest"].id
      app   = azurerm_linux_web_app.web["devtest"].name
      url   = "https://${azurerm_linux_web_app.web["devtest"].default_hostname}"
      slot  = "production"
    }
    staging = {
      scope = azurerm_linux_web_app_slot.staging.id
      app   = azurerm_linux_web_app.web["production"].name
      url   = "https://${azurerm_linux_web_app_slot.staging.default_hostname}"
      slot  = azurerm_linux_web_app_slot.staging.name
    }
    production = {
      scope = azurerm_linux_web_app.web["production"].id
      app   = azurerm_linux_web_app.web["production"].name
      url   = var.bind_production_domain ? "https://${var.production_domain}" : "https://${azurerm_linux_web_app.web["production"].default_hostname}"
      slot  = azurerm_linux_web_app_slot.staging.name
    }
  }
}

resource "azurerm_user_assigned_identity" "release" {
  for_each            = local.environments
  name                = "${var.name_prefix}-${each.key}-github"
  resource_group_name = azurerm_resource_group.hosting.name
  location            = azurerm_resource_group.hosting.location
}

resource "azurerm_federated_identity_credential" "release" {
  for_each            = local.environments
  name                = "github-${each.key}"
  resource_group_name = azurerm_resource_group.hosting.name
  parent_id           = azurerm_user_assigned_identity.release[each.key].id
  issuer              = "https://token.actions.githubusercontent.com"
  audience            = ["api://AzureADTokenExchange"]
  subject             = "repo:${local.repository}:environment:${each.key}"
}

resource "azurerm_role_assignment" "release" {
  for_each                         = local.environments
  scope                            = each.value.scope
  role_definition_name             = "Website Contributor"
  principal_id                     = azurerm_user_assigned_identity.release[each.key].principal_id
  skip_service_principal_aad_check = true
}

resource "github_repository_environment" "release" {
  for_each            = local.environments
  repository          = var.github_repository
  environment         = each.key
  prevent_self_review = each.key == "production"
  can_admins_bypass   = false

  dynamic "reviewers" {
    for_each = each.key == "production" ? [var.production_reviewer_ids] : []
    content {
      users = reviewers.value
    }
  }

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

resource "github_repository_environment_deployment_policy" "develop" {
  for_each       = local.environments
  repository     = var.github_repository
  environment    = github_repository_environment.release[each.key].environment
  branch_pattern = "develop"
}

# Enable the push workflow only after its deployment protections and identities exist.
resource "github_actions_variable" "release_enabled" {
  repository    = var.github_repository
  variable_name = "AZURE_RELEASE_ENABLED"
  value         = var.enable_release_workflow ? "true" : "false"

  depends_on = [
    github_repository_environment_deployment_policy.develop,
    github_actions_environment_variable.release,
    azurerm_federated_identity_credential.release,
    azurerm_role_assignment.release,
  ]
}

locals {
  release_variables = merge([
    for name, env in local.environments : {
      for key, value in {
        AZURE_CLIENT_ID       = azurerm_user_assigned_identity.release[name].client_id
        AZURE_TENANT_ID       = azurerm_user_assigned_identity.release[name].tenant_id
        AZURE_SUBSCRIPTION_ID = var.subscription_id
        AZURE_RESOURCE_GROUP  = azurerm_resource_group.hosting.name
        AZURE_WEBAPP_NAME     = env.app
        AZURE_SLOT            = env.slot
        APP_URL               = env.url
        STAGING_URL           = local.environments["staging"].url
      } : "${name}/${key}" => { environment = name, name = key, value = value }
    }
  ]...)
}

resource "github_actions_environment_variable" "release" {
  for_each      = local.release_variables
  repository    = var.github_repository
  environment   = github_repository_environment.release[each.value.environment].environment
  variable_name = each.value.name
  value         = each.value.value
}
