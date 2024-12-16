resource "azurerm_redis_cache" "redis-cluster-1" {
  name                          = var.cluster_name
  location                      = var.resource_group_location
  resource_group_name           = var.resource_group_name
  capacity                      = var.cluster_capacity
  family                        = var.cluster_family
  sku_name                      = var.cluster_sku
  non_ssl_port_enabled          = var.non_ssl_port_enabled
  minimum_tls_version           = var.cluster_tls_version
  public_network_access_enabled = var.cluster_public_network_access

  redis_configuration {
    maxmemory_reserved = 10
    maxmemory_delta    = 2
    maxmemory_policy   = "allkeys-lru"
  }

  # aadEnableDisable property
  identity {
    type = "SystemAssigned"
  }
}