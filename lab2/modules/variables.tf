variable "rg_name" { type = string }
variable "rg_location" { type = string }
variable "vnet_name" { type = string }

variable "subnet_name" {
  type    = string
  default = "dev-subnet"
}

variable "public_ip_name" {
  type    = string
  default = "TestVMpublicIP"
}

variable "nic_name" {
  type    = string
  default = "Test-VM-nic"
}

variable "nsg_name" {
  type    = string
  default = "TestSecurityGroup"
}

variable "vm_name" {
  type    = string
  default = "TestVM"
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "vm_count" {
  type    = number
  default = 1
}