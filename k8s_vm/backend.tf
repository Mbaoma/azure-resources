terraform {
  backend "azurerm" {
    resource_group_name  = "backend_tf"
    storage_account_name = "backendtf1storage"
    container_name       = "backendtf1storagec0nta1ner"
    key                  = "vm-for-k8s/terraform.tfstate"
  }
}