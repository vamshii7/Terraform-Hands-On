module "module_prod" {
    source = "./modules"
    rg_name         = "ttt-prod-rg"
    rg_location     = "East US"
    vnet_name       = "prod-vnet"
    subnet_name     = "prod-subnet"
    public_ip_name  = "prod-public-ip"
    nic_name        = "prod-nic"
    nsg_name        = "prod-nsg"
    vm_name         = "prod-vm"
    vm_size         = "Standard_B1s"
    admin_username  = "azureuser"
    admin_password  = "DevPassword!123"
    vm_count        = 1
}