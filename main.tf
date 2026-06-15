resource "azurerm_resource_group" "rg" {
  name     = "muez-final-project2-rg" # 👈 اسم جديد كلياً وغير مكرر نهائياً
  location = "swedencentral"

  tags = {
    Project     = "Project2"
    Environment = "production"
    StudentName = var.student_name
  }
}

resource "azurerm_container_group" "aci" {
  name                = "muez-final-aci-group" # 👈 اسم جديد للحاوية
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  dns_name_label      = "muez-final-cloudscale-app" # 👈 اسم ويب فريد وجديد
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

    # 👈 الأسطر القادمة تقوم بمسح الصفحة الافتراضية وكتابة صفحتك الخاصة فوراً!
    commands = [
      "/bin/sh",
      "-c",
      "echo '<h1>Welcome to CloudScale App</h1><p>Student Name: Muez Islam  Mohammed</p><p>Project 2 is Running Successfully!</p>' > /usr/share/nginx/html/index.html && nginx -g 'daemon off;'"
    ]
  }

  tags = {
    Project     = "Project2"
    Environment = "production"
    StudentName = var.student_name
  }
}
