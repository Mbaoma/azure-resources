variable "resource_group_name" {
  default = "k8s-vm-rg"
}

variable "resource_group_location" {
  default = "East US"
}

variable "virtual_network_name" {
  default = "k8s-vm-vnet"
}

variable "virtual_network_address_space" {
  default = ["10.0.0.0/16"]
}

variable "subnet_name" {
  default = "k8s-subnet-name"
}

variable "subnet_name_address_prefix" {
  default = ["10.0.2.0/24"]
}

variable "network_interface_name" {
  default = "k8s-vm-nic"
}

variable "ip_configuration" {
  default = "k8svmip1"
}

variable "private_ip_address_allocation" {
  default = "Dynamic"
}

variable "master_vm_name" {
  default = "k8s-vm-master"
}

variable "vm_size" {
  default = "Standard_B2s"
}

variable "worker1_vm_name" {
  default = "k8s-vm-worker1"
}

variable "worker2_vm_name" {
  default = "k8s-vm-worker2"
}