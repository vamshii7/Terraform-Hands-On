
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
variable "resource_group_name" {
  type        = string
}

variable "linux_vm_count" {
  type        = number
  default     = 1
}

variable "windows_vm_count" {
  type        = number
  default     = 1
}

variable "admin_username" {
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  type        = string
  sensitive   = true
  default = "P@ssw0rd1234"
}

variable "subnet_id" {
  description = "Subnet ID from network module"
  type        = string
}
