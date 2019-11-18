terraform {
  required_version = ">= 0.12"
}

data "azurerm_resource_group" "main" {
  name = "${var.resource-group}"
}
data azurerm_virtual_network "main" {
    name                    = "${var.vnet-name}"
    resource_group_name     = "${var.resource-group}"
}
data "azurerm_subnet" "main" {
  name                 = "${var.subnet-name}"
  virtual_network_name = "${var.vnet-name}"
  resource_group_name  = "${var.resource-group}"
}