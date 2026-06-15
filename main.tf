resource "azurerm_resource_group" "rg" {
  name     = "muez-final-project2-rg"
  location = "swedencentral"

  tags = {
    Project     = "Project2"
    Environment = "production"
    StudentName = var.student_name
  }
}

resource "azurerm_container_group" "aci" {
  name                = "muez-final-aci-group"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  dns_name_label      = "muez-final-cloudscale-app"
  os_type             = "Linux"

  container {
    name   = "webserver"
    image  = "nginx:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  tags = {
    Project     = "Project2"
    Environment = "production"
    StudentName = var.student_name
  }
}
