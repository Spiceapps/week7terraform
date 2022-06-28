resource "azurerm_linux_virtual_machine" "myvms" {
   name                   = var.machineName
   location               = var.resource_group_location
   availability_set_id    = var.avasetid
   resource_group_name    = var.rgname
   network_interface_ids  = [var.networkInterfaceid]
   size                   = var.VMSize
   #delete_os_disk_on_termination = var.deldisk

    source_image_reference {
         publisher = "Canonical"
         offer     = "0001-com-ubuntu-server-focal"
         sku       = var.UbuntuVersion
         version   = "latest"
    }

   os_disk {
     name               = var.diskName
     caching           = "ReadWrite"
     storage_account_type = "Premium_LRS"
   }
    admin_username = var.vmusername
    admin_password = var.adminpassword
    disable_password_authentication = false
}