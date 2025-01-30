provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks_rg" {
  name     = "aks-resource-group"
  location = "East US"
}

module "network" {
  source          = "./modules/network"
  location        = azurerm_resource_group.aks_rg.location
  resource_group  = azurerm_resource_group.aks_rg.name
}

module "cluster" {
  source         = "./modules/cluster"
  location       = azurerm_resource_group.aks_rg.location
  resource_group = azurerm_resource_group.aks_rg.name
  subnet_id      = module.network.subnet_id
}

