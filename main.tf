provider "azurerm" {
    version = "=2.5.0"
    features {}
}


resource "azurerm_resource_group" "rg" {
    name     = "myTFResourceGroup"
    location = "West Europe"
}

resource "azurerm_storage_account" "processinglayers" {
  name                     = "processinglayers"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
//  tags                     = "${local.tags}"
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "GRS"
//  access_tier              = "Hot"
//  enable_https_traffic_only = true
  depends_on               = [azurerm_resource_group.rg]

}

resource "azurerm_storage_container" "raw" {
  name                  = "raw"
  storage_account_name  = azurerm_storage_account.processinglayers.name
  container_access_type = "private"
  depends_on = [azurerm_storage_account.processinglayers]
}