
data "azurerm_subscription" "current_sub" {}

resource "azurerm_resource_group" "rg" {
  name                                = var.rg_name
  location                            = var.location
  tags                                = var.tag
}

resource "azurerm_log_analytics_workspace" "log_anal_wks" {
  depends_on                          = [azurerm_resource_group.rg]
  name                                = var.la_wks_name
  location                            = azurerm_resource_group.rg.location
  resource_group_name                 = azurerm_resource_group.rg.name
  sku                                 = var.la_wks_sku
  retention_in_days                   = var.la_wks_retention_in_days
  internet_ingestion_enabled          = true
  internet_query_enabled              = true
  tags                                = var.tag
}

resource "azurerm_security_center_workspace" "sec_cen_wks" {
  scope                               = var.sec_cen_wks_scope != "" ? var.sec_cen_wks_scope : data.azurerm_subscription.current_sub.id
  workspace_id                        = azurerm_log_analytics_workspace.log_anal_wks.id
}

resource "azurerm_security_center_automation" "sec_cen_automation" {
  count                               = var.sec_cen_setting_enabled ? 1 : 0
  name                                = var.sec_cen_auto_name
  location                            = azurerm_resource_group.rg.location
  resource_group_name                 = azurerm_resource_group.rg.name
  scopes                              = [data.azurerm_subscription.current_sub.id]
  enabled                             = var.sec_cen_setting_enabled
  action {
    type                              = "LogAnalytics"
    resource_id                       = azurerm_log_analytics_workspace.log_anal_wks.id
  }
  source {
    event_source                      = "Alerts"
    rule_set {
      rule {
        property_path                 = "properties.metadata.severity"
        operator                      = "Equals"
        expected_value                = "High"
        property_type                 = "String"
      }
    }
  }
  tags                                = var.tag
}

resource "azurerm_security_center_subscription_pricing" "sec_cen_price" {
  for_each                            = toset(var.sec_cen_price_res)
  resource_type                       = each.value
  tier                                = var.sec_cen_price_tier
}

resource "azurerm_security_center_contact" "sec_cen_contact" {
  email                               = lookup(var.sec_cen_contacts, "email")
  phone                               = lookup(var.sec_cen_contacts, "phone")
  alert_notifications                 = lookup(var.sec_cen_contacts, "alert_notifications", true)
  alerts_to_admins                    = lookup(var.sec_cen_contacts, "alerts_to_admins", true)
}

resource "azurerm_security_center_setting" "sec_cen_setting" {
  count        = var.sec_cen_setting_enabled ? 1 : 0
  setting_name = var.sec_cen_setting_name
  enabled      = var.sec_cen_setting_enabled
}

resource "azurerm_security_center_auto_provisioning" "sec_cen_auto_prov" {
  count          = var.sec_cen_auto_prov_enable == "On" ? 1 : 0
  auto_provision = var.sec_cen_auto_prov_enable
}

