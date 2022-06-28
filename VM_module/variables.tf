variable "resource_group_location" {
  default = "eastus"
  description   = "Location of the resource group."
}

variable "VMSize" {
  default = "Standard_DS1_v2"
  description = "Choosen size for the VM variable"
}

variable "UbuntuVersion" {
  type = string
  default ="20_04-lts-gen2"
  description = "Choosen ubuntu version for the VM variable"
}

variable "vmusername" {
 type = string
 default = "azureadmin"
 description = "Choose username for Virtual Machines"
}

variable "networkInterfaceid" {
    type = string
}

variable "machineName" {
    type = string
}

variable "diskName" {
    type = string
}

variable "adminpassword" {
    type = string
}

variable "avasetid" {
    type = string
}

variable "rgname" {
    type = string
}

variable "deldisk" {
  type = string
  default = "true"
  
}