variable "prefix" {
    description = "Prefix for resource names"
    type        = string
    default = "demo"
}
variable "location" {
    description = "Azure region for resources"
    type        = string
    default     = "East US"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default = [ "10.0.0.0/16" ]
}

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "The address prefixes to use for the subnet."
  default = ["10.0.0.0/24"]
}
variable "resource_group_name" {
  type = string
}