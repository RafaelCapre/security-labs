resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-secure"
  location            = var.location
  resource_group_name = var.resource_group
  dns_prefix          = "aks-secure"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  role_based_access_control_enabled = true
}

