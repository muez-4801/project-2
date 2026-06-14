terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "61e822a8-758e-427e-9026-e3b5d46fdd22"
  client_id       = "de021fdd-06ac-413f-b247-0868fad8089c"
  tenant_id       = "a8a6d952-dc1e-4b83-97e1-18ff70df777f"
}

