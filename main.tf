terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}



module "resource_group" {
  source  = "./modules/resource_group"
  rg_name = var.rg_name
  location = var.location
}

module "storage" {
  source         = "./modules/storage"
  rg_name        = module.resource_group.rg_name
  storage_name   = var.storage_name
  location       = var.location
}

module "apim" {
  source          = "./modules/apim"
  rg_name         = module.resource_group.rg_name
  location        = var.location
  apim_name       = var.apim_name
  publisher_name  = var.publisher_name
  publisher_email = var.publisher_email
}

module "api" {
  source             = "./modules/api"
  rg_name            = module.resource_group.rg_name
  apim_name          = module.apim.apim_name
  api_name           = var.api_name
}

