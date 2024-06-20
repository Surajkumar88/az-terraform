terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm",
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "az-rgs" {
  for_each = var.az-rg-list
  name     = each.key
  location = each.value.location
  tags = {
    source  = "terraform"
    rg-num  = each.value.tags[0]
    rg-word = each.value.tags[1]
  }
}

resource "azurerm_virtual_network" "az-vnet-1" {
  name                = values(var.az-vnet-vars)[0]["name"]
  location            = values(azurerm_resource_group.az-rgs)[0].location
  resource_group_name = values(azurerm_resource_group.az-rgs)[0].name
  address_space       = values(var.az-vnet-vars)[0]["address_space"]
  depends_on          = [azurerm_resource_group.az-rgs]
}

resource "azurerm_subnet" "az-subnet-1" {
  name                 = values(var.az-subnet-vars)[0]["name"]
  virtual_network_name = azurerm_virtual_network.az-vnet-1.name
  resource_group_name  = values(azurerm_resource_group.az-rgs)[0].name
  address_prefixes     = values(var.az-subnet-vars)[0]["address_prefixes"]
}

resource "azurerm_public_ip" "az-pub-ip-1" {
  name                = values(var.az-pub-ip-vars)[0]["name"]
  resource_group_name = values(azurerm_resource_group.az-rgs)[0].name
  location            = values(azurerm_resource_group.az-rgs)[0].location
  allocation_method   = values(var.az-pub-ip-vars)[0]["allocation_method"]
  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_network_interface" "az-net-interface-1" {
  name                = var.az-interface-vars
  location            = values(azurerm_resource_group.az-rgs)[0].location
  resource_group_name = values(azurerm_resource_group.az-rgs)[0].name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.az-subnet-1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.az-pub-ip-1.id
  }
  depends_on = [azurerm_public_ip.az-pub-ip-1]
}

resource "azurerm_linux_virtual_machine" "az-nginx-1" {
  name                            = values(var.az-vm-1-vars)[0]["name"]
  resource_group_name             = lookup(var.az-rg-list-vm, terraform.workspace, "dev")
  #values(azurerm_resource_group.az-rgs)[0].name
  location                        = values(azurerm_resource_group.az-rgs)[0].location
  size                            = values(var.az-vm-1-vars)[0]["vm_size"]
  admin_username                  = values(var.az-vm-1-vars)[0]["username"]
  admin_password                  = values(var.az-vm-1-vars)[0]["password"]
  user_data                       = base64encode(file("${path.module}/scripts/nginx_installer.sh"))
  network_interface_ids           = [azurerm_network_interface.az-net-interface-1.id]
  disable_password_authentication = false


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = values(var.az-vm-1-vars)[0]["os_publisher"]
    offer     = values(var.az-vm-1-vars)[0]["os_image"]
    sku       = values(var.az-vm-1-vars)[0]["os_sku"]
    version   = values(var.az-vm-1-vars)[0]["os_image_version"]
  }
}

