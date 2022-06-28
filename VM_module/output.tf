output "vm_password" {
    #value = azurerm_linux_virtual_machine.myvms.*.admin_password
    value = var.adminpassword
    sensitive = true
}