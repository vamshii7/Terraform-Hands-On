variable "location" {
  type    = string
  default = "Central India"
}

variable "rg_name" {
  type    = string
  default = "rg-ttt-prod"
}

variable "vnet_name" {
  type    = string
  default = "vnet-ttt-prod"
}

variable "vnet_cidr" {
  type    = string
  default = "10.30.0.0/16"
}

variable "aks_subnet_name" {
  type    = string
  default = "snet-aks"
}

variable "aks_subnet_cidr" {
  type    = string
  default = "10.30.1.0/24"
}

variable "acr_name" {
  type    = string
  default = "acrtttprod"
}

variable "aks_name" {
  type    = string
  default = "aks-ttt-prod"
}

variable "dns_prefix" {
  type    = string
  default = "ttt"
}

variable "kubernetes_version" {
  type    = string
  default = null
}

variable "node_count" {
  type    = number
  default = 1
}

variable "node_size" {
  type    = string
  default = "Standard_D4s_v5"
}