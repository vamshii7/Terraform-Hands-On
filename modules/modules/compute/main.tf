resource "azurerm_network_interface" "linux_nic" {
  count               = var.linux_vm_count
  name                = "${var.prefix}-linux-nic-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "windows_nic" {
  count               = var.windows_vm_count
  name                = "${var.prefix}-win-nic-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count               = var.linux_vm_count
  name                = "${var.prefix}-linux-vm-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B1s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [azurerm_network_interface.linux_nic[count.index].id]
  disable_password_authentication = false

  os_disk {
    name                 = "${var.prefix}-linux-osdisk-${count.index}"
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

resource "azurerm_windows_virtual_machine" "windows_vm" {
  count               = var.windows_vm_count
  name                = "${var.prefix}-win-vm-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B1s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [azurerm_network_interface.windows_nic[count.index].id]

  os_disk {
    name                 = "${var.prefix}-win-osdisk-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

output "linux_vm_names" {
  value = azurerm_linux_virtual_machine.linux_vm[*].name
}

output "windows_vm_names" {
  value = azurerm_windows_virtual_machine.windows_vm[*].name
}
