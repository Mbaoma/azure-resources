# #Resource Group
variable "resource_group_name" {
  default = "redis"
}

variable "resource_group_location" {
  default = "East US"
}

#Redis
variable "cluster_name" {
  default = "Arcan3zzzzt"
}

variable "cluster_capacity" {
  default = 2
}

variable "cluster_family" {
  default = "C"
}

variable "cluster_sku" {
  default = "Standard"
}

variable "cluster_tls_version" {
  default = "1.2"
}

variable "cluster_public_network_access" {
  default = true
}

variable "non_ssl_port_enabled" {
  default = true
}


#git filter-repo --invert-paths --path
#redis-config/.terraform/providers/registry.terraform.io/hashicorp/azurerm/4.8.0/darwin_arm64/terraform-provider-azurerm_v4.8.0_x5