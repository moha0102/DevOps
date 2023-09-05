
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.71.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "moha-resource-webapp"
  location = "West Europe"
}

resource "azurerm_service_plan" "example" {
  name                = "moha-service-plan"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku_name            = "P1v2"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "example" {
  name                = "mohammaddotnetsju"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_service_plan.example.location
  service_plan_id     = azurerm_service_plan.example.id

  site_config {
    application_stack {
        dotnet_version = "v7.0"
    }
  }
}

output "publish_profile" {
  value = azurerm_windows_web_app.example.site_credential
  sensitive = true
}