#testcomment
resource "azurerm_virtual_network" "myvnet" {
    name = "myvnet"
    location = azurerm_resource_group.myrglab.location
    resource_group_name = azurerm_resource_group.myrglab.name
    address_space = ["10.0.0.0/16"]
    depends_on = [
      azurerm_resource_group.myrglab
    ]
      
}

resource "azurerm_subnet" "mysubnet" {
    name = "mysubnet"
    resource_group_name = azurerm_resource_group.myrglab.name
    virtual_network_name = azurerm_virtual_network.myvnet.name
    address_prefixes = [ "10.0.0.0/24" ]
    depends_on = [
      azurerm_virtual_network.myvnet
    ]
      
}

resource "azurerm_network_security_group" "mynsg" {
    name                = "mynsg"
    location            = azurerm_resource_group.myrglab.location
    resource_group_name = azurerm_resource_group.myrglab.name

    security_rule {
        name                       = "ssh"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "22"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
  }
  
}

resource "azurerm_network_interface" "myvnic" {
    name = "myvnic"
    location = azurerm_resource_group.myrglab.location
    resource_group_name = azurerm_resource_group.myrglab.name

    ip_configuration {
      name = "internal"
      subnet_id = azurerm_subnet.mysubnet.id
      private_ip_address_allocation = "Dynamic"
    }
    depends_on = [
      azurerm_subnet.mysubnet
    ]
  
}

