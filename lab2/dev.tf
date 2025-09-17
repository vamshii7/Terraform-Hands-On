module "module_dev" {
    source = "./modules"
    rg_name         = "ttt-dev-rg"
    rg_location     = "East US"
    vnet_name       = "dev-vnet"
    subnet_name     = "dev-subnet"
    public_ip_name  = "dev-public-ip"
    nic_name        = "dev-nic"
    nsg_name        = "dev-nsg"
    vm_name         = "dev-vm"
    vm_size         = "Standard_B1s"
    admin_username  = "azureuser"
    admin_password  = "DevPassword!123"
    vm_count           = 1
}