terraform {
  backend "azurerm" {
    resource_group_name   = "tfstate-rg"
    storage_account_name  = "tfremotestatedevelop"
    container_name        = "tfstateseccencontainer"
    key                   = "tfstate/secconstate"
  }
}