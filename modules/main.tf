terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.43.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location
  
}

module "network" {
  source   = "./modules/network"
  prefix   = var.prefix
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

module "compute" {
  source            = "./modules/compute"
  prefix            = var.prefix
  resource_group_name = azurerm_resource_group.rg.name
  location          = var.location
  linux_vm_count    = var.linux_vm_count
  windows_vm_count  = var.windows_vm_count
  admin_username    = var.admin_username
  admin_password    = var.admin_password
  subnet_id         = module.network.subnet_id
}

output "linux_vm_names" {
  value = module.compute.linux_vm_names
}

output "windows_vm_names" {
  value = module.compute.windows_vm_names
}
