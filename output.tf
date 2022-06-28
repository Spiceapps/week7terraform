output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "public_ip_address" {
  value = azurerm_public_ip.loadbalancerIP.ip_address
}

output "azurerm_postgresql_flexible_server_fqdn" {
  value = azurerm_postgresql_flexible_server.myweek6psqlflexibleserver.fqdn
}

output "db_admin_password" {
  value = azurerm_postgresql_flexible_server.myweek6psqlflexibleserver.administrator_password
  sensitive = true
}

output "vm_admin_password" {
  value = var.vmadminpass
  sensitive = true
}