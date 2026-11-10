locals {
  tags = { project = "jausi", managed-by = "terraform" }
  apps = {
    devtest    = { suffix = "devtest", sku = "B1" }
    production = { suffix = "prod", sku = "S1" }
  }
}

resource "azurerm_resource_group" "hosting" {
  name     = "${var.name_prefix}-hosting"
  location = var.location
  tags     = local.tags
}

resource "azurerm_service_plan" "web" {
  for_each            = local.apps
  name                = "${var.name_prefix}-${each.value.suffix}-plan"
  resource_group_name = azurerm_resource_group.hosting.name
  location            = azurerm_resource_group.hosting.location
  os_type             = "Linux"
  sku_name            = each.value.sku
  tags                = local.tags
}

resource "azurerm_linux_web_app" "web" {
  for_each                                       = local.apps
  name                                           = "${var.name_prefix}-${each.value.suffix}"
  resource_group_name                            = azurerm_resource_group.hosting.name
  location                                       = azurerm_resource_group.hosting.location
  service_plan_id                                = azurerm_service_plan.web[each.key].id
  https_only                                     = true
  ftp_publish_basic_authentication_enabled        = false
  webdeploy_publish_basic_authentication_enabled = false
  tags                                           = local.tags

  app_settings = {
    SCM_DO_BUILD_DURING_DEPLOYMENT = "false"
    WEBSITE_SWAP_WARMUP_PING_PATH  = "/healthz"
    WEBSITE_SWAP_WARMUP_PING_STATUSES = "200"
  }

  site_config {
    always_on                         = true
    ftps_state                        = "Disabled"
    health_check_path                 = "/healthz"
    health_check_eviction_time_in_min = 5
    app_command_line                  = "node server.mjs"

    application_stack {
      node_version = "22-lts"
    }
  }
}

resource "azurerm_linux_web_app_slot" "staging" {
  name                                           = "staging"
  app_service_id                                 = azurerm_linux_web_app.web["production"].id
  https_only                                     = true
  ftp_publish_basic_authentication_enabled        = false
  webdeploy_publish_basic_authentication_enabled = false
  tags                                           = local.tags

  app_settings = {
    SCM_DO_BUILD_DURING_DEPLOYMENT = "false"
    WEBSITE_SWAP_WARMUP_PING_PATH  = "/healthz"
    WEBSITE_SWAP_WARMUP_PING_STATUSES = "200"
  }

  site_config {
    always_on                         = true
    ftps_state                        = "Disabled"
    health_check_path                 = "/healthz"
    health_check_eviction_time_in_min = 5
    app_command_line                  = "node server.mjs"

    application_stack {
      node_version = "22-lts"
    }
  }
}

resource "azurerm_app_service_custom_hostname_binding" "production" {
  count               = var.bind_production_domain ? 1 : 0
  hostname            = var.production_domain
  app_service_name    = azurerm_linux_web_app.web["production"].name
  resource_group_name = azurerm_resource_group.hosting.name

  lifecycle {
    ignore_changes = [ssl_state, thumbprint]
  }
}

resource "azurerm_app_service_managed_certificate" "production" {
  count                      = var.bind_production_domain ? 1 : 0
  custom_hostname_binding_id = azurerm_app_service_custom_hostname_binding.production[0].id
}

resource "azurerm_app_service_certificate_binding" "production" {
  count               = var.bind_production_domain ? 1 : 0
  hostname_binding_id = azurerm_app_service_custom_hostname_binding.production[0].id
  certificate_id      = azurerm_app_service_managed_certificate.production[0].id
  ssl_state           = "SniEnabled"
}

output "production_dns" {
  value = {
    hostname             = var.production_domain
    asuid_txt_value      = azurerm_linux_web_app.web["production"].custom_domain_verification_id
    azure_default_domain = azurerm_linux_web_app.web["production"].default_hostname
  }
}

output "hosting_resource_group" {
  value = azurerm_resource_group.hosting.name
}

output "production_app_name" {
  value = azurerm_linux_web_app.web["production"].name
}
