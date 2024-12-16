resource "azurerm_resource_group" "azure-redis" {
  name     = var.resource_group_name
  location = var.resource_group_location
}