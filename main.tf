provider "azurerm" {
  features {}
  skip_provider_registration = true
 }

terraform {

  backend "azurerm" {
    container_name       = "terraform"
    storage_account_name = "gaterraform"
    resource_group_name  = "TF_State"
    key                  = "GA-TF-Statefile"
  }
}

#create resource group
resource "azurerm_resource_group" "rg" {
    name     = "rg-${var.resourcegroup}"
    location = var.location
  }

  #create virtual network
resource "azurerm_virtual_network" "network" {
    name     = var.network
    resource_group_name = azurerm_resource_group.rg.name
    location = var.location
    address_space = [ "10.0.0.0/16" ]
  }
  
  #create subnet
resource "azurerm_subnet" "subnet" {
    name     = var.subnet
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.network.name
    address_prefix = "10.0.1.0/24"
  }

  #create subnet
resource "azurerm_subnet" "subnet1" {
    name     = var.subnet1
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.network.name
    address_prefix = "10.0.2.0/24"
  }
  #create nic
  resource "azurerm_network_interface" "main" {
  name                = "${var.vm1}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  
   ip_configuration {
    name = "test"
    subnet_id = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    }
  }
  #Public IP
  resource "azurerm_public_ip" "PublicIP" {
  name                = "PublicIp1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  allocation_method   = "Static"
  }
  #create VM
resource "azurerm_virtual_machine" "vm1" {
os_profile_windows_config { 
}
    name = var.vm1
    resource_group_name = azurerm_resource_group.rg.name
    location = var.location
    vm_size = "Standard_F2"
    network_interface_ids = [azurerm_network_interface.main.id]
    os_profile {
      admin_username = var.username
      admin_password = var.password
      computer_name = var.vm1
    }
    
    storage_os_disk {
      name = "myosdisk1"
      caching = "ReadWrite"
      create_option = "FromImage"
      managed_disk_type = "Standard_LRS"
    } 

    storage_image_reference {
      publisher = "MicrosoftWindowsServer"
      offer = "WindowsServer"
      sku = "2016-Datacenter"
      version = "latest"
  }
}
© 2022 GitHub, Inc.
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About
