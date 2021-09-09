resource "azurerm_linux_virtual_machine" "mylinuxvm" {
    name = "mylinuxvm"
    resource_group_name = azurerm_resource_group.myrglab.name
    location = azurerm_resource_group.myrglab.location
    size = "Standard_B1s"
    admin_username = "azadmin"
    network_interface_ids = [ 
        azurerm_network_interface.myvnic.id,
        ]
    os_disk {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference {
      publisher = "Canonical"
      sku = "18.04-LTS"
      offer = "UbuntuServer"
      version = "latest"
    }
}