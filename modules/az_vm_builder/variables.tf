###### Resource Group variables #################################
variable "az-rg-list" {
  type = map(object({
    location = string
    tags     = list(string)
  }))
}

###### Vnet variables #################################
variable "az-vnet-vars" {
  type = map(object({
    name                = string
    resource_group_name = string
    address_space       = list(string)
    location            = string
  }))
}

###### subnet variables #################################
variable "az-subnet-vars" {
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}
###### interface variables #################################
variable "az-interface-vars" {
  type = string
}
###### public IP variables #################################
variable "az-pub-ip-vars" {
  type = map(object({
    name              = string
    allocation_method = string
  }))
}
###### virtual machine variables #################################
variable "az-vm-1-vars" {
  type = map(object({
    name             = string
    vm_size          = string
    os_publisher     = string
    os_image         = string
    os_sku           = string
    os_image_version = string
    username         = string
    password         = string
  }))
}
