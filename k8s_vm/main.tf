resource "azurerm_resource_group" "duckling" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_virtual_network" "main" {
  name                = var.virtual_network_name
  address_space       = var.virtual_network_address_space
  location            = azurerm_resource_group.duckling.location
  resource_group_name = azurerm_resource_group.duckling.name
}

resource "azurerm_subnet" "internal" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.duckling.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.subnet_name_address_prefix
}

resource "azurerm_network_interface" "master_node" {
  name                = var.network_interface_name_master_node
  location            = azurerm_resource_group.duckling.location
  resource_group_name = azurerm_resource_group.duckling.name
  #   depends_on          = [azurerm_virtual_machine.master]

  ip_configuration {
    name                          = var.ip_configuration_master_node
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}
resource "azurerm_network_interface" "worker_node1" {
  name                = var.network_interface_name_worker_node1
  location            = azurerm_resource_group.duckling.location
  resource_group_name = azurerm_resource_group.duckling.name
  #   depends_on          = [azurerm_virtual_machine.worker1]

  ip_configuration {
    name                          = var.ip_configuration_worker_node1
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}
resource "azurerm_network_interface" "worker_node2" {
  name                = var.network_interface_name_worker_node2
  location            = azurerm_resource_group.duckling.location
  resource_group_name = azurerm_resource_group.duckling.name
  #   depends_on          = [azurerm_virtual_machine.worker2]

  ip_configuration {
    name                          = var.ip_configuration_worker_node2
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}



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
    computer_name  = "workernode"
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

resource "azurerm_virtual_machine" "worker2" {
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
    computer_name  = "workernode"
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