terraform {
    backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "temptfstatesa"
    container_name       = "tfstate"
    key                  = "test.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}