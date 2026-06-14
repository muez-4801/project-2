resource "azurerm_resource_group" "rg" {
  name     = "-proj2-aci-rg"
  location = "swedencentral" # 👈 تم وضع السويد هنا مباشرة

  tags = {
    Project     = "Project2"
    Environment = "production"
    StudentName = var.student_name
  }
}

resource "azurerm_container_group" "aci" {
  name                = "-aci-group"
  location            = azurerm_resource_group.rg.location # سيأخذ "swedencentral" تلقائياً من الـ RG
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  dns_name_label      = "-cloudscale-app"
  os_type             = "Linux"

  container {
    name   = "webserver"
    image  = var.docker_image
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