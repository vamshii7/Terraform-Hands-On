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
    vm_password = string
    vnet_cidr   = string
    subnet_cidr = string
  }))
}