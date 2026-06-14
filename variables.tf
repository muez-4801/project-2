variable "student_name" {
  type        = string
  description = "Your name for resource naming"
  default     = "muez"
}

variable "location" {
  type        = string
  description = "Azure Region"
  default     = "East US"
}

variable "docker_image" {
  type        = string
  description = "Docker Hub image path"
  default     = "muez1710/cloudscale-app:v1"
}
