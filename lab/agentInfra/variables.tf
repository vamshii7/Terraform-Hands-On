variable "admin_password" {
  type      = string
  sensitive = true
}

variable "ado_org_url" {
  type = string
}

variable "ado_pat" {
  type      = string
  sensitive = true
}