resource "azurerm_resource_group" "main" {
  name     = "kubecon-2023"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = "kyverno"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "aks-kyverno"

  default_node_pool {
    name                = "default"
    node_count          = 1
    vm_size             = "Standard_D4as_v4"
    max_count           = 10
    enable_auto_scaling = true
  }

  network_profile {
    network_plugin = "kubenet"
  }
  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "testing"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "spot" {
  name                  = "spotnp"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = "Standard_D4as_v4"
  enable_auto_scaling   = true
  priority              = "Spot"
  spot_max_price        = -1
  min_count             = 1
  node_count            = 1
  eviction_policy       = "Delete"
  node_taints           = ["kubernetes.azure.com/scalesetpriority=spot:NoSchedule"]

  lifecycle {
    ignore_changes = [node_count]
  }
  tags = {
    Environment = "testing"
  }
}
