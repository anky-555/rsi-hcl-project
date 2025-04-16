terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.24.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "RSIRG" {
  name     = "rg1"
  location = "west europe"
}

resource "azurerm_storage_account" "RSISA" {
  depends_on              = [azurerm_resource_group.RSIRG]
  name                    = "sa1"
  location                = azurerm_resource_group.RSIRG.location
  resource_group_name     = azurerm_resource_group.RSIRG.name
  account_tier            = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "RSISC" {
  depends_on            = [azurerm_storage_account.RSISA]
  name                  = "sc1"
  storage_account_id    = azurerm_storage_account.RSISA.id
  container_access_type = "private"
}
