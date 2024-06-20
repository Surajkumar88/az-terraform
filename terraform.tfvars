###### Resource Group variables #################################
az-rg-list = {
  "dev" = {
    location = "centralindia"
    tags = ["rg-1", "dev"]
  }
  "qa" = {
    location = "southindia"
    tags = ["rg-2", "qa"]
  }
  "prod" = {
    location = "westindia"
    tags = ["rg-3", "prod"]
  }
}
az-rg-list-vm = {
  "dev" = "dev"
  "qa" = "qa"
  "prod" = "prod"
}

###### Vnet variables #################################
az-vnet-vars = {
  az-vnet-1 = {
    name = "az-vnet-1"
    resource_group_name = "vnet-random"
    address_space = ["10.0.0.0/16"]
    location = "southindia"
  }
}

###### subnet variables #################################
az-subnet-vars = {
  az-subnet-1 = {
    name = "az-subnet-1"
    address_prefixes = ["10.0.1.0/24"]
  }
}

###### interface variables #################################
az-interface-vars = "az-net-interface-1"

###### public IP variables #################################
az-pub-ip-vars = {
  az-pub-ip-1 = {
    name = "az-pub-ip-1"
    allocation_method = "Dynamic"
  }
}

###### virtual machine variables #################################
az-vm-1-vars = {
  "az-vm-1" = {
    name = "az-nginx-server-1"
    vm_size = "Standard_B1s"
    os_publisher = "Canonical"
    os_image = "0001-com-ubuntu-server-jammy"
    os_sku = "22_04-lts"
    os_image_version = "latest"
    username = "midas"
    password = "Password1234!"
  }
}