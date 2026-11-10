# Optional: DNS records remain managed by the current DNS provider unless
# the team explicitly chooses an Azure DNS zone and delegates the domain.
resource "azurerm_dns_zone" "production" {
  count               = var.manage_azure_dns ? 1 : 0
  name                = var.production_domain
  resource_group_name = azurerm_resource_group.hosting.name
  tags                = local.tags
}

resource "azurerm_dns_txt_record" "verification" {
  count               = var.manage_azure_dns ? 1 : 0
  name                = "asuid"
  zone_name           = azurerm_dns_zone.production[0].name
  resource_group_name = azurerm_resource_group.hosting.name
  ttl                 = 300

  record {
    value = azurerm_linux_web_app.web["production"].custom_domain_verification_id
  }
}

resource "azurerm_dns_a_record" "production" {
  count               = var.manage_azure_dns && var.production_apex_ipv4 != null ? 1 : 0
  name                = "@"
  zone_name           = azurerm_dns_zone.production[0].name
  resource_group_name = azurerm_resource_group.hosting.name
  ttl                 = 300
  records             = [var.production_apex_ipv4]
}

output "azure_dns_name_servers" {
  value = var.manage_azure_dns ? azurerm_dns_zone.production[0].name_servers : []
}
