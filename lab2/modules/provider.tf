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