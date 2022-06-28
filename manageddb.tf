# Create private subnet for the managed DB
resource "azurerm_subnet" "DB-net" {
  name                 = "${var.resource_group_name_prefix}-DB-net"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.week6network.name
  address_prefixes     = ["10.0.3.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name    = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", ]
    }
  }
}

# DNS zone for DB
resource "azurerm_private_dns_zone" "mydbdns" {
  name                = "${var.resource_group_name_prefix}-mydbdns.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
}

# DNS zone link
resource "azurerm_private_dns_zone_virtual_network_link" "mydnslink" {
  name                  = "${var.resource_group_name_prefix}-exampleVnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.mydbdns.name
  virtual_network_id    = azurerm_virtual_network.week6network.id
  resource_group_name   = azurerm_resource_group.rg.name
}

# Create postgre flexible server
resource "azurerm_postgresql_flexible_server" "myweek6psqlflexibleserver" {
  name                   = "${var.resource_group_name_prefix}-myweek6psqlflexibleserver"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  version                = "13"
  delegated_subnet_id    = azurerm_subnet.DB-net.id
  private_dns_zone_id    = azurerm_private_dns_zone.mydbdns.id
  administrator_login    = "azureadmin"
  administrator_password = var.vmadminpass
  zone                   = "1"

  storage_mb = 32768

  sku_name   = "B_Standard_B1ms"
  depends_on = [azurerm_private_dns_zone_virtual_network_link.mydnslink]

}

#  azurerm_postgresql_flexible_server_database
resource "azurerm_postgresql_flexible_server_database" "db" {
  name      = "db"
  server_id = azurerm_postgresql_flexible_server.myweek6psqlflexibleserver.id
  collation = "en_US.utf8"
  charset   = "utf8"

}

#  azurerm_postgresql_flexible_server_firewall_rule
resource "azurerm_postgresql_flexible_server_firewall_rule" "dbfirewall" {
  name      = "dbfirewall"
  server_id = azurerm_postgresql_flexible_server.myweek6psqlflexibleserver.id

  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"

}

#  azurerm_postgresql_flexible_server_configuration
resource "azurerm_postgresql_flexible_server_configuration" "flexible_server_configuration" {
  name      = "require_secure_transport"
  server_id = azurerm_postgresql_flexible_server.myweek6psqlflexibleserver.id
  value     = "off"
}