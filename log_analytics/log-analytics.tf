resource "azurerm_resource_group" "log_analytics" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_log_analytics_workspace" "log_analytics_poc" {
  name                = var.log_analytics_workspace_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}