# Resource Group names
output "resource_group_names" {
  description = "Names of the resource groups created per environment"
  value       = { for k, rg in azurerm_resource_group.this : k => rg.name }
}

# VNet names and address spaces
output "vnet_info" {
  description = "Virtual network names and address spaces per environment"
  value = {
    for k, vnet in azurerm_virtual_network.this :
    k => {
      name          = vnet.name
      address_space = vnet.address_space
    }
  }
}

# Subnet IDs
output "subnet_ids" {
  description = "Subnet IDs per environment"
  value       = { for k, sn in azurerm_subnet.this : k => sn.id }
}

# NIC IDs
output "nic_ids" {
  description = "Network interface IDs per environment"
  value       = { for k, nic in azurerm_network_interface.this : k => nic.id }
}

# VM public IPs (if you add a public IP resource later)
# For now, we can output VM names and IDs
output "vm_info" {
  description = "VM names and IDs per environment"
  value = {
    for k, vm in azurerm_linux_virtual_machine.this :
    k => {
      name = vm.name
      id   = vm.id
    }
  }
}