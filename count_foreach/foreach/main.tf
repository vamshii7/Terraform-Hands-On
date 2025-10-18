resource "azurerm_resource_group" "this" {
    name = "${var.prefix}-rg"
    location = var.env == "prod" ? "East US" : "West US"
}

# resource "azurerm_virtual_network" "this" {
#     name = "${var.prefix}-vnet"
#     address_space = ["10.0.0.0/16"] 
#     location = azurerm_resource_group.this.location
#     resource_group_name = azurerm_resource_group.this.name
# }
# resource "azurerm_subnet" "this"