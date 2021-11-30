variable "rg_name" {
  type                      = string
  description               = "A resource group for the ASC log analytics workspace "
  default                   = "sec-cen-rg"
}
variable "location" {
  type                      = string
  description               = "Region location for the ASC log analytics workspace "
  default                   = "westus2"
}
variable "tag" {
  description               = "A mapping of tags which should be assigned to the Resource"
  default = {
    Enviorment              = "Dev"
    Project                 = "Test"
  }
}
variable "la_wks_name" {
  type                      = string
  description               = "Specifies the name of the Log Analytics Workspace"
  default                   = "sec-cen-logana-wks"
}
variable "la_wks_sku" {
  type                      = string
  description               = "Specifies the Sku of the Log Analytics Workspace"
  default                   = "PerGB2018"
}
variable "la_wks_retention_in_days" {
  type                      = number
  description               = "The workspace data retention in days."
  default                   = 30
}
variable "sec_cen_wks_scope" {
  type                      = string
  description               = "The scope of VMs to send their security data to the desired workspace"
  default                   = ""
}
variable "sec_cen_price_tier" {
  type                      = string
  description               = "The pricing tier to use"
  default                   = "Free"
}
variable "sec_cen_price_res" {
  type                      = list(string)
  description               = "The resource type this setting affects"
}
variable "sec_cen_contacts" {
  type        = map(string)
  description = "Manages the subscription's Security Center Contact"
  default     = {}
}
variable "sec_cen_setting_name" {
  type                      = string
  description               = "The setting to manage"
  default                   = "MCAS"
}
variable "sec_cen_setting_enabled" {
  type                      = bool
  description               = "Boolean flag to enable/disable data access"
  default                   = false
}
variable "sec_cen_auto_prov_enable" {
  type                      = string
  description               = "Should the security agent be automatically provisioned on Virtual Machines in this subscription"
  default                   = "Off"
}
variable "sec_cen_auto_name" {
  type                      = string
  description               = "The name which should be used for this Security Center Automation"
  default                   = "sec-cen-auto"
}