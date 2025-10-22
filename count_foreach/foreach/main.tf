resource "azurerm_resource_group" "this" {
  for_each = var.resourcedetails
  name     = each.value.rg_name
  location = each.value.rg_location
}

resource "azurerm_virtual_network" "this" {
  for_each            = var.resourcedetails
  name                = each.value.vnet_name
  address_space       = ["10.${each.key == "DevInfra" ? 0 : 1}.0.0/16"]
  location            = azurerm_resource_group.this[each.key].location
  resource_group_name = azurerm_resource_group.this[each.key].name
}

resource "azurerm_subnet" "this" {
  for_each             = var.resourcedetails
  name                 = each.value.subnet_name
  resource_group_name  = each.value.rg_name
  virtual_network_name = azurerm_virtual_network.this[each.key].name
  address_prefixes     = ["10.${each.key == "DevInfra" ? 0 : 1}.1.0/24"]
}

resource "azurerm_network_interface" "this" {
  for_each            = var.resourcedetails
  name                = "${each.value.vm_name}-nic"
  location            = azurerm_resource_group.this[each.key].location
  resource_group_name = azurerm_resource_group.this[each.key].name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.this[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  for_each              = var.resourcedetails
  name                  = each.value.vm_name
  location              = azurerm_resource_group.this[each.key].location
  resource_group_name   = azurerm_resource_group.this[each.key].name
  size                  = "Standard_B1s"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.this[each.key].id]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}