resource "azurerm_resource_group" "main" {
  name     = "kubecon-2023"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = "kyverno"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  default_node_pool {
    name                = "default"
    node_count          = 1
    vm_size             = "Standard_D2_v2"
    enable_auto_scaling = true
  }

  network_profile {
    network_plugin = "kubenet"
  }
  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}
