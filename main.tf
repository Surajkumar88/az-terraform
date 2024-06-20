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

module "az_nginx_server" {
  source = "./modules/az_nginx_server"
  az-rg-list = var.az-rg-list
  az-rg-list-vm = var.az-rg-list-vm
  az-subnet-vars = var.az-subnet-vars
  az-interface-vars = var.az-interface-vars
  az-vnet-vars = var.az-vnet-vars
  az-pub-ip-vars = var.az-pub-ip-vars
  az-vm-1-vars = var.az-vm-1-vars

}

output "nginx-server-public-ip" {
  value = module.az_nginx_server
}