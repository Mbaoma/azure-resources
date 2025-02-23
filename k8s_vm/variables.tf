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
  default = "k8s-subnet"
}

variable "subnet_name_address_prefix" {
  default = ["10.0.2.0/24"]
}

variable "network_interface_name_master_node" {
  default = "k8s-vm-master-node"
}

variable "network_interface_name_worker_node1" {
  default = "k8s-vm-worker-node1"
}


variable "network_interface_name_worker_node2" {
  default = "k8s-vm-worker-node2"
}

variable "ip_configuration_master_node" {
  default = "k8svmip1"
}

variable "ip_configuration_worker_node1" {
  default = "k8svmip2"
}

variable "ip_configuration_worker_node2" {
  default = "k8svmip3"
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
  default = "new-k8s-vm-worker2"
}

variable "public_ip_master_node_name" {
  default = "k8s-vm-master-node"
}

variable "public_ip_allocation_method" {
  default = "Static"
}

variable "public_ip_worker_node1_name" {
  default = "k8s-vm-worker-node1"
}

variable "public_ip_worker_node2_name" {
  default = "k8s-vm-worker-node2"
}

variable "sku" {
  default = "Standard"
}

variable "nsg_master_node_name" {
  default = "k8s-vm-master-node-nsg"
}

variable "nsg_worker_node1_name" {
  default = "k8s-vm-worker-node1-nsg"
}

variable "nsg_worker_node2_name" {
  default = "k8s-vm-worker-node2-nsg"
}

