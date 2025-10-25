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
# # Raw JSON strings coming from pipeline variable groups
# variable "resource_groups" {
#   description = "JSON string containing resource group details per environment"
#   type        = string
# }

# variable "network_details" {
#   description = "JSON string containing network details per environment"
#   type        = string
# }

# variable "vm_details" {
#   description = "JSON string containing VM details per environment"
#   type        = string
# }