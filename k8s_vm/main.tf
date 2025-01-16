###############################################################################
# Resource Group
###############################################################################
resource "azurerm_resource_group" "duckling" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

###############################################################################
# Virtual Network
###############################################################################
resource "azurerm_virtual_network" "main" {
  name                = var.virtual_network_name
  address_space       = var.virtual_network_address_space
  location            = azurerm_resource_group.duckling.location
  resource_group_name = azurerm_resource_group.duckling.name
}

###############################################################################
# Subnet
###############################################################################
resource "azurerm_subnet" "internal" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.duckling.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.subnet_name_address_prefix
}

# MASTER NODE
###############################################################################
# Network Interface
###############################################################################
resource "azurerm_network_interface" "master_node" {
  name                = var.network_interface_name_master_node
  location            = azurerm_resource_group.duckling.location
  resource_group_name = azurerm_resource_group.duckling.name

  ip_configuration {
    name                          = var.ip_configuration_master_node
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.master_node.id
  }
}

###############################################################################
# Network Interface Security Group Association
###############################################################################
resource "azurerm_network_interface_security_group_association" "master_node" {
  network_interface_id      = azurerm_network_interface.master_node.id
  network_security_group_id = azurerm_network_security_group.master_node.id
}

###############################################################################
# Public IP
###############################################################################
resource "azurerm_public_ip" "master_node" {
  name                = var.public_ip_master_node_name
  location            = azurerm_resource_group.duckling.location
  resource_group_name = azurerm_resource_group.duckling.name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.sku
  lifecycle {
    create_before_destroy = true
  }
}

###############################################################################
# Security Group
###############################################################################
resource "azurerm_network_security_group" "master_node" {
  name                = var.nsg_master_node_name
  location            = azurerm_resource_group.duckling.location
  resource_group_name = azurerm_resource_group.duckling.name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowOpenApi"
    priority                   = 1004
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "6443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

###############################################################################
# Virtual Machine
###############################################################################
resource "azurerm_virtual_machine" "master" {
  name                  = var.master_vm_name
  location              = azurerm_resource_group.duckling.location
  resource_group_name   = azurerm_resource_group.duckling.name
  network_interface_ids = [azurerm_network_interface.master_node.id]
  vm_size               = var.vm_size

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk0"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "masternode"
    admin_username = "master"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    node = "master"
  }
}

# WORKER NODE 1

###############################################################################
# Network Interface
###############################################################################
resource "azurerm_network_interface" "worker_node1" {
  name                = var.network_interface_name_worker_node1
  location            = azurerm_resource_group.duckling.location
  resource_group_name = azurerm_resource_group.duckling.name
  #   depends_on          = [azurerm_virtual_machine.worker1]

  ip_configuration {
    name                          = var.ip_configuration_worker_node1
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.worker_node1.id
  }
}

###############################################################################
# Network Interface Security Group Association
###############################################################################
resource "azurerm_network_interface_security_group_association" "worker_node1" {
  network_interface_id      = azurerm_network_interface.worker_node1.id
  network_security_group_id = azurerm_network_security_group.worker_node1.id
}

###############################################################################
# Public IP
###############################################################################
resource "azurerm_public_ip" "worker_node1" {
  name                = var.public_ip_worker_node1_name
  location            = azurerm_resource_group.duckling.location
  resource_group_name = azurerm_resource_group.duckling.name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.sku
  lifecycle {
    create_before_destroy = true
  }
}

###############################################################################
# Security Group
###############################################################################
resource "azurerm_network_security_group" "worker_node1" {
  name                = var.nsg_worker_node1_name
  location            = azurerm_resource_group.duckling.location
  resource_group_name = azurerm_resource_group.duckling.name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowKubectlNodes"
    priority                   = 1004
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowOpenApi"
    priority                   = 1005
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "6443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

###############################################################################
# Virtual Machine
###############################################################################
resource "azurerm_virtual_machine" "worker1" {
  name                  = var.worker1_vm_name
  location              = azurerm_resource_group.duckling.location
  resource_group_name   = azurerm_resource_group.duckling.name
  network_interface_ids = [azurerm_network_interface.worker_node1.id]
  vm_size               = var.vm_size

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "workernode1"
    admin_username = "worker1"
    admin_password = "Password12345!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    node = "worker1"
  }
}

# WORKER NODE 2
###############################################################################
# Network Interface
###############################################################################
resource "azurerm_network_interface" "worker_node2" {
  name                = var.network_interface_name_worker_node2
  location            = azurerm_resource_group.duckling.location
  resource_group_name = azurerm_resource_group.duckling.name
  #   depends_on          = [azurerm_virtual_machine.worker2]

  ip_configuration {
    name                          = var.ip_configuration_worker_node2
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.worker_node2.id
  }
}

###############################################################################
# Network Interface Security Group Association
###############################################################################
resource "azurerm_network_interface_security_group_association" "worker_node2" {
  network_interface_id      = azurerm_network_interface.worker_node2.id
  network_security_group_id = azurerm_network_security_group.worker_node2.id
}

###############################################################################
# Public IP
###############################################################################
resource "azurerm_public_ip" "worker_node2" {
  name                = var.public_ip_worker_node2_name
  location            = azurerm_resource_group.duckling.location
  resource_group_name = azurerm_resource_group.duckling.name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.sku
  lifecycle {
    create_before_destroy = true
  }
}

###############################################################################
# Security Group
###############################################################################
resource "azurerm_network_security_group" "worker_node2" {
  name                = var.nsg_worker_node2_name
  location            = azurerm_resource_group.duckling.location
  resource_group_name = azurerm_resource_group.duckling.name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowKubectlNodes"
    priority                   = 1004
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowOpenApi"
    priority                   = 1005
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "6443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

###############################################################################
# Virtual Machine
###############################################################################
resource "azurerm_virtual_machine" "worker_node2" {
  name                  = var.worker2_vm_name
  location              = azurerm_resource_group.duckling.location
  resource_group_name   = azurerm_resource_group.duckling.name
  network_interface_ids = [azurerm_network_interface.worker_node2.id]
  vm_size               = var.vm_size

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk3"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "workernode2"
    admin_username = "worker2"
    admin_password = "Password123456"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    node = "worker2"
  }
}