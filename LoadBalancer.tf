# Create public IP for Load Balancer
resource "azurerm_public_ip" "loadbalancerIP" {
   name                         = "publicIPForLB"
   location                     = azurerm_resource_group.rg.location
   resource_group_name          = azurerm_resource_group.rg.name
   allocation_method            = "Static"
}

#Load Balancer
resource "azurerm_lb" "week5LB" {
   name                = "loadBalancer"
   location            = azurerm_resource_group.rg.location
   resource_group_name = azurerm_resource_group.rg.name

   frontend_ip_configuration {
     name                 = "publicIPAddress"
     public_ip_address_id = azurerm_public_ip.loadbalancerIP.id
   }
}

resource "azurerm_lb_backend_address_pool" "lb_backendPool" {
   loadbalancer_id     = azurerm_lb.week5LB.id
   name                = "BackEndAddressPool"
}

# Configure Load Balancer rules

resource "azurerm_lb_rule" "webappAccessRule" {
  loadbalancer_id                = azurerm_lb.week5LB.id
  name                           = "LBRuleWebApp"
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 8080
  frontend_ip_configuration_name = azurerm_lb.week5LB.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_backendPool.id]
  probe_id                       = azurerm_lb_probe.sshProbe.id
}

# Load Balancer NAT Rule
resource "azurerm_lb_nat_rule" "sshAccessRule" {
  resource_group_name            = azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.week5LB.id
  name                           = "SSHAccess"
  protocol                       = "Tcp"
  frontend_port                  = 22
  backend_port                   = 22
  frontend_ip_configuration_name = "publicIPAddress"
}

# Load Balancer NAT Rule association to the first VN NIC
resource "azurerm_network_interface_nat_rule_association" "sshtofirstvm" {
  network_interface_id  = azurerm_network_interface.NIC.0.id
  ip_configuration_name = "mainConfiguration"
  nat_rule_id           = azurerm_lb_nat_rule.sshAccessRule.id
}

#Configure Load Balancer Probe
resource "azurerm_lb_probe" "sshProbe" {
  loadbalancer_id = azurerm_lb.week5LB.id
  name            = "ssh-running-probe"
  port            = 22
}
resource "azurerm_network_interface_backend_address_pool_association" "example" {
  count                   = var.vmcount
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backendPool.id
  ip_configuration_name   = "mainConfiguration"
  network_interface_id    = element(azurerm_network_interface.NIC.*.id, count.index)
}