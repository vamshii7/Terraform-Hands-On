variable "subscription_id" {
  type = string
}
variable "tenant_id" {
  type = string
}
variable "resourcedetails" {
  description = "Map of resource details for multiple environments"
  type = map(object({
    rg_name     = string
    rg_location = string
    vnet_name   = string
    subnet_name = string
    vm_name     = string
  }))

  default = {
    DevInfra = {
      rg_name     = "dev-rg"
      rg_location = "East US"
      vnet_name   = "dev-vnet"
      subnet_name = "dev-subnet"
      vm_name     = "dev-vm"
    }
    ProdInfra = {
      rg_name     = "prod-rg"
      rg_location = "East US"
      vnet_name   = "prod-vnet"
      subnet_name = "prod-subnet"
      vm_name     = "prod-vm"
    }
  }
}