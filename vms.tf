#create app vms using module 
module "vmmodule" {
  source = "./VM_module"
  count                = "${var.vmcount}"
  UbuntuVersion        = var.UbuntuVersion
  VMSize               = var.VMSize
  resource_group_location  = var.RGlocation
  machineName          = "acctvm${count.index}"
  networkInterfaceid   = element(azurerm_network_interface.NIC.*.id, count.index)
  avasetid             = azurerm_availability_set.avset.id
  rgname               = azurerm_resource_group.rg.name
  diskName             = "myosdisk${count.index}"
  #adminpassword        = random_password.password.result
  adminpassword         = var.vmadminpass
}