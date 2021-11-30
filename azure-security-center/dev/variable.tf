variable "sub_id" {
  type                      = string
  default                   = "c620fbc5-c7b2-4385-bf9d-ff55c8428699"
}
variable "tenent_id" {
  type                      = string
  default                   = "29aa20a1-f851-4f76-89ac-720d25551793"
}
variable "client_id" {
  type                      = string
  default                   = ""
}
variable "client_secret" {
  type                      = string
  default                   = ""
}
variable "sec_cen_setting_enabled" {
  type                      = bool
  default                   = true
}
variable "sec_cen_auto_prov_enable" {
  type                      = string
  default                   = "On"
}