# Generate unique VM/Agent name

resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}

locals {
  vm_name = "agent-${random_integer.suffix.result}"
}

# Resource Group (static)

resource "azurerm_resource_group" "rg" {
  name     = "${local.vm_name}-rg"
  location = "East US"
}

# Virtual Network + Subnet

resource "azurerm_virtual_network" "vnet" {
  name                = "${local.vm_name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "${local.vm_name}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Public IP

resource "azurerm_public_ip" "vm_pip" {
  name                = "${local.vm_name}-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Network Interface

resource "azurerm_network_interface" "vm_nic" {
  name                = "${local.vm_name}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_pip.id
  }
}

# NSG to allow SSH

resource "azurerm_network_security_group" "nsg" {
  name                = "${local.vm_name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "nic_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Minimal Ubuntu VM

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = local.vm_name
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_B1s"
  network_interface_ids           = [azurerm_network_interface.vm_nic.id]
  admin_username                  = "agent"
  admin_password                  = var.admin_password
  disable_password_authentication = false

  os_disk {
    name                 = "${local.vm_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  # Provisioner to install ADO agent
  
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      host     = azurerm_public_ip.vm_pip.ip_address
      user     = "agent"
      password = var.admin_password
    }

    inline = [
      "sudo apt-get update -y || true",
      "sudo apt-get install -y wget tar || true",
      "mkdir -p ~/agent && cd ~/agent",
      "wget https://download.agent.dev.azure.com/agent/4.261.0/vsts-agent-linux-x64-4.261.0.tar.gz",
      "tar zxvf vsts-agent-linux-x64-4.261.0.tar.gz",
      "./config.sh --unattended --url ${var.ado_org_url} --auth pat --token ${var.ado_pat} --pool Default --agent ${local.vm_name} --acceptTeeEula",
      "sudo ./svc.sh install",
      "sudo ./svc.sh start"
    ]
  }
}
