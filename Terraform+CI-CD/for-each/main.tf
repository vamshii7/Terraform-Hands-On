locals {
  # Decode JSON strings into usable maps
  resource_groups = jsondecode(var.resource_groups)
  network_details = jsondecode(var.network_details)
  vm_details      = jsondecode(var.vm_details)
}

# -------------------------
# Debug outputs
# -------------------------

# Raw strings (exactly as passed from pipeline)
output "debug_resource_groups_raw" {
  value = var.resource_groups
  sensitive = true   # mark sensitive to avoid leaking in logs
}

output "debug_network_details_raw" {
  value = var.network_details
  sensitive = true
}

output "debug_vm_details_raw" {
  value = var.vm_details
  sensitive = true
}

# Decoded maps (usable in for_each)
output "debug_resource_groups_decoded" {
  value = local.resource_groups
}

output "debug_network_details_decoded" {
  value = local.network_details
}

output "debug_vm_details_decoded" {
  value = {
    for k, v in local.vm_details :
    k => {
      vm_name = v.vm_name
      # mask the password so it doesn’t print in logs
      vm_password = "*****"
    }
  }
}

resource "azurerm_resource_group" "this" {
  for_each = local.resource_groups
  name     = each.value.rg_name
  location = each.value.rg_location
}

resource "azurerm_virtual_network" "this" {
  for_each            = local.network_details
  name                = each.value.vnet_name
  address_space       = [each.value.vnet_cidr]
  location            = azurerm_resource_group.this[each.key].location
  resource_group_name = azurerm_resource_group.this[each.key].name
}

resource "azurerm_subnet" "this" {
  for_each             = local.network_details
  name                 = each.value.subnet_name
  resource_group_name  = azurerm_resource_group.this[each.key].name
  virtual_network_name = azurerm_virtual_network.this[each.key].name
  address_prefixes     = [each.value.subnet_cidr]
}

resource "azurerm_network_interface" "this" {
  for_each            = local.vm_details
  name                = "${each.value.vm_name}-nic"
  location            = azurerm_resource_group.this[each.key].location
  resource_group_name = azurerm_resource_group.this[each.key].name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.this[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  for_each              = local.vm_details
  name                  = each.value.vm_name
  location              = azurerm_resource_group.this[each.key].location
  resource_group_name   = azurerm_resource_group.this[each.key].name
  size                  = "Standard_B1s"
  admin_username        = "azureuser"
  admin_password        = each.value.vm_password
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.this[each.key].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}