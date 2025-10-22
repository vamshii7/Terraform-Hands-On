variable "admin-password" {
  type      = string
  sensitive = true
}

variable "ado-org-url" {
  type = string
}

variable "ado-pat" {
  type      = string
  sensitive = true
}