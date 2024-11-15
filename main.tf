terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.116.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-config"
    storage_account_name = "maitetfstorage"
    container_name       = "terraform"
    key                  = "lesson-1.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "973fdd3a-5b34-4a45-964a-28db471b9165"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-terraform"
  location = "East US"
}

resource "azurerm_network_watcher" "nw" {
  name                = "testnw"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

data "azurerm_resource_group" "rg1" {
  name = "WestUs2"
}

resource "azurerm_network_watcher" "nw1" {
  name                = "testnw1"
  resource_group_name = data.azurerm_resource_group.rg1.name
  location            = data.azurerm_resource_group.rg1.location
}
