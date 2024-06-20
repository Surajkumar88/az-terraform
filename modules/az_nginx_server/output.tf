output "nginx-server-details" {
  value = [azurerm_linux_virtual_machine.az-nginx-1.name, azurerm_linux_virtual_machine.az-nginx-1.public_ip_address, azurerm_linux_virtual_machine.az-nginx-1.resource_group_name]
}