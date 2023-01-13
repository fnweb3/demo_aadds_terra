#Network aadds

resource "azurerm_virtual_network" "aadds" {
  name                = "aadds-vnet"
  location            = azurerm_resource_group.aadds.location
  resource_group_name = azurerm_resource_group.aadds.name
  address_space       = [var.vnet_aadds] 

 #Aadds DCs
  dns_servers = var.dns_servers
}
resource "azurerm_subnet" "aadds" {
  name                 = "aadds-subnet"
  resource_group_name  = azurerm_resource_group.aadds.name
  virtual_network_name = azurerm_virtual_network.aadds.name
  address_prefixes     = [var.subnet_aadds]
}

resource "azurerm_network_security_group" "aadds" {
  name                = "aadds-nsg"
  location            = azurerm_resource_group.aadds.location
  resource_group_name = azurerm_resource_group.aadds.name

  security_rule {
    name                       = "AllowSyncWithAzureAD"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "AzureActiveDirectoryDomainServices"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowRD"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "CorpNetSaw"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowPSRemoting"
    priority                   = 301
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefix      = "AzureActiveDirectoryDomainServices"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowLDAPS"
    priority                   = 401
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "636"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "aadds" {
  subnet_id                 = azurerm_subnet.aadds.id
  network_security_group_id = azurerm_network_security_group.aadds.id
}


