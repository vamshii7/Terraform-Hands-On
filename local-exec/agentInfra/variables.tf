variable "admin_password" {
  type      = string
  sensitive = true
  default   = "Terraform@123"
}

variable "ado_org_url" {
  type = string
  default = "https://dev.azure.com/vamshii7/"
}

variable "ado_pat" {
  type      = string
  sensitive = true
}

variable "subscription_id" {
  type = string
}
variable "tenant_id" {
 type = string 
}