terraform {
  backend "azurerm" {
    resource_group_name  = "Practice-DevOps"
    storage_account_name = "tfbackendstorageautomate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
