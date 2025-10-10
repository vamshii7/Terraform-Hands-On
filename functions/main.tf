# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "~> 4.0"
#     }
#   }
# }

# provider "azurerm" {
#   features {}
# }

# ------------------------
# RESOURCE GROUP
# ------------------------
resource "azurerm_resource_group" "rg" {
  name     = lower("${var.prefix}-${var.env}-rg")
  location = var.location
}

# ------------------------
# VNET + SUBNETS (using cidrsubnet & count)
# ------------------------
resource "azurerm_virtual_network" "vnet" {
  name                = format("%s-%s-vnet", var.prefix, var.env)
  address_space       = [var.vnet_cidr]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnets" {
  count                = var.subnet_count
  name                 = format("subnet-%03d", count.index + 1)
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(var.vnet_cidr, 8, count.index)]
}

# ------------------------
# NICs
# ------------------------
resource "azurerm_network_interface" "nics" {
  count               = var.vm_count
  name                = format("%s-%s-nic-%03d", var.prefix, var.env, count.index + 1)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal-ip"
    subnet_id                     = element(azurerm_subnet.subnets.*.id, count.index % var.subnet_count)
    private_ip_address_allocation = "Dynamic"
  }
}

# ------------------------
# LINUX VMs
# ------------------------
resource "azurerm_linux_virtual_machine" "vms" {
  count                           = var.vm_count
  name                            = format("%s-%s-vm-%03d", var.prefix, var.env, count.index + 1)
  location                        = azurerm_resource_group.rg.location
  resource_group_name             = azurerm_resource_group.rg.name
  size                            = lookup(var.vm_sizes, var.env, "Standard_B2s")
  admin_username                  = "azureuser"
  admin_password                  = "P@ssword1234!"
  network_interface_ids           = [azurerm_network_interface.nics[count.index].id]
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  # Adding tags using functions
  tags = {
    environment   = upper(var.env)
    project       = replace(var.project_name, " ", "-")
    created_at    = timestamp()
    contact_email = coalesce(var.override_email, var.default_email, "admin@example.com")
  }
}

# ------------------------
# OUTPUTS
# ------------------------
output "vm_names" {
  value = [for vm in azurerm_linux_virtual_machine.vms : vm.name]
}

output "vm_private_ips" {
  value = [for nic in azurerm_network_interface.nics : nic.private_ip_address]
}

output "allowed_ips_csv" {
  value = join(",", var.ip_list)
}