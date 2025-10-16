variable "rg_location" {
  type    = string
  default = "East US"
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
  default   = "DevPassword!123"
}
variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]

}
variable "subnet_address_prefixes" {
  type    = list(string)
  default = ["10.0.0.0/24"]
}
variable "vm_count" {
  type    = number
  default = 1
}

variable "prefix" {
  type    = string
}