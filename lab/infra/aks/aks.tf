resource "azurerm_kubernetes_cluster" "this" {
  name                = var.aks_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = var.dns_prefix

  kubernetes_version  = var.kubernetes_version
  oidc_issuer_enabled = true
  workload_identity_enabled = true

  default_node_pool {
    name       = "sysnp"
    node_count = var.node_count
    vm_size    = var.node_size
    vnet_subnet_id = azurerm_subnet.aks.id
    type       = "VirtualMachineScaleSets"
    enable_auto_scaling  = true
    min_count            = 1
    max_count            = 3
  }

  identity { type = "SystemAssigned" }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
    load_balancer_sku  = "standard"
    outbound_type      = "loadBalancer"
    dns_service_ip     = "10.0.0.10"
    service_cidr       = "10.0.0.0/16"
    docker_bridge_cidr = "172.17.0.1/16"
  }

  role_based_access_control_enabled = true
  lifecycle { ignore_changes = [kubernetes_version] }
}

output "kubelet_identity_object_id" {
  value = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive = true
}

output "host" { value = azurerm_kubernetes_cluster.this.kube_config[0].host }
