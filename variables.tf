variable "resource_group_name_prefix" {
  default       = "prod"
  description   = "Prefix of the resource group name to differentiate environments."
}

variable "RGname" {
  default = "RG_VM_with_postgresSQL"
  description = "RG_VM_with_postgresSQL"
}

variable "RGlocation" {
  default = "eastus"
  description   = "Location of the resource group."
}

variable "vmcount" {
  type = number
  default = 3  
}

variable "AllowedIPforRemoteSSH" {
  type = string
  default = "84.228.18.103"
}

variable "VMSize" {
  #default = "Standard_DS1_v2"
  default = "Standard_B1s"
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
 description = "Choose userbame for Virtual Machines"

}

variable "vmadminpass" {
 type = string
 default = "tempP4ssw0rd!"
 description = "Choose userbame for Virtual Machines"
}