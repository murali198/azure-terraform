provider "azurerm" {
  version                   = "=2.86.0"
  subscription_id           = var.sub_id
  tenant_id                 = var.tenent_id
  client_id                 = var.client_id
  client_secret             = var.client_secret
  features {}
}

locals {
  sec_cen_price_res         = ["VirtualMachines", "StorageAccounts"]
}
module "security_center" {
  source                    = "../../module/security-center"
  sec_cen_price_res         = local.sec_cen_price_res
  sec_cen_setting_enabled   = var.sec_cen_setting_enabled
  sec_cen_auto_prov_enable  = var.sec_cen_auto_prov_enable
  sec_cen_contacts = {
    email                   = "hnikhi@gmail.com"
    phone                   = "+13102104559"
    alert_notifications     = true
    alerts_to_admins        = true
  }
}