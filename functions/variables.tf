# ------------------------
# VARIABLES
# ------------------------
variable "prefix" {
  default = "dev"
}

variable "env" {
  default = "dev"
}

variable "location" {
  default = "eastus"
}

variable "vnet_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_count" {
  default = 2
}

variable "vm_count" {
  default = 2
}

variable "project_name" {
  default = "Finance App"
}

variable "ip_list" {
  default = ["10.0.0.4", "10.0.0.5"]
}

variable "vm_sizes" {
  type = map(string)
  default = {
    dev  = "Standard_B1s"
    prod = "Standard_B2s"
  }
}

variable "default_email" {
  default = "itops@example.com"
}

variable "override_email" {
  default = ""
}