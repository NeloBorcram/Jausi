terraform {
  required_version = ">= 1.8, < 2.0"

  backend "azurerm" {
    use_azuread_auth = true
    container_name   = "tfstate"
    key              = "jausi-hosting.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "github" {
  owner = var.github_owner
}
