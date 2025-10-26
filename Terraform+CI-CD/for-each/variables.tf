variable "resource_groups" {
  type = map(object({
    rg_name     = string
    rg_location = string
  }))
}

variable "network_details" {
  type = map(object({
    vnet_name   = string
    subnet_name = string
    vnet_cidr   = string
    subnet_cidr = string
  }))
}

variable "vm_details" {
  type = map(object({
    vm_name     = string
    vm_password = string
  }))
}

# variable "resource_groups" {
#   type        = map(any)
#   description = "Resource group details per environment"
# }

# variable "network_details" {
#   type        = map(any)
#   description = "Network details per environment"
# }

# variable "vm_details" {
#   type        = map(any)
#   description = "VM details per environment"
# }