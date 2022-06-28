# Generate resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name_prefix}-${var.RGname}"
  location = var.RGlocation
}


# Define availability set
resource "azurerm_availability_set" "avset" {
   name                         = "avset"
   location                     = azurerm_resource_group.rg.location
   resource_group_name          = azurerm_resource_group.rg.name
   platform_fault_domain_count  = 2
   platform_update_domain_count = 2
   managed                      = true
 }