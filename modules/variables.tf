variable "prefix" {
  description = "Prefix for resource naming"
  default     = "demo"
}

variable "location" {
  description = "Azure region"
  default     = "eastus"
}

variable "linux_vm_count" {
  description = "Number of Linux VMs to create"
  default     = 1
}

variable "windows_vm_count" {
  description = "Number of Windows VMs to create"
  default     = 1
}

variable "admin_username" {
  description = "Admin username for the VMs"
  default     = "azureuser"
}

variable "admin_password" {
  description = "Admin password for the VMs"
  default     = "P@ssw0rd1234!"
}
