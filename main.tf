resource "azurerm_resource_group" "rg" {
  name     = "muez-proj2-aci-rg" # 👈 تم تغيير الاسم ليصبح فريداً وجديداً تماماً
  location = "swedencentral"      # 👈 موقع السويد جاهز ومثبت هنا

  tags = {
    Project     = "Project2"
    Environment = "production"
    StudentName = var.student_name
  }
}

resource "azurerm_container_group" "aci" {
  name                = "muez-aci-group" # 👈 تم إزالة الشرطة من البداية وتغيير الاسم
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  dns_name_label      = "muez-cloudscale-app" # 👈 اسم الـ DNS أصبح فريداً ونظيفاً لكي يقبله Azure
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
