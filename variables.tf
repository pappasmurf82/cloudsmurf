variable "resourcegroup" {
    type = string
    description = "Name of the Resource Group"
    default = "PlayPen"
}
variable "location" {
    type = string
    description = "Azure location of terraform server environment"
    default = "westus2"

}
variable "network" {
    type = string
    description = "Name of network"
    default = "MasterVNET"

}

variable "subnet" {
    type = string
    description = "Name of Subnet"
    default = "MasterSubnet"

}
variable "subnet1" {
    type = string
    description = "Name of Subnet"
    default = "Subnet1"

}
variable "vm1" {
    type = string
    description = "Name of First VM"
    default = "VM-1"

}
variable "password" {
    type = string
    description = "Admin Password"
    default = "Azure2021!"

}
variable "username" {
    type = string
    description = "Admin Username"
    default = "GAAdmin"

}

