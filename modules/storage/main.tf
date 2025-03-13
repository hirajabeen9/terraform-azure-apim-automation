resource "azurerm_storage_account" "storage" {
  name                     = "mystorage${random_id.storage.hex}" # Change this line
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "random_id" "storage" {
  byte_length = 4
}
