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
  client_id       = "fce97da6-3054-4b20-9501-3b4eb524e886"
  tenant_id       = "70d14e82-b071-41e7-a84b-d17297930785"
  subscription_id = "5db43b7e-7ec8-40ed-9358-9f8a6adc0baf"
  client_secret   = "VGr8Q~aQyMKt6PkRD1xNLcYSWnVch~nMNeZKfaEl"
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
