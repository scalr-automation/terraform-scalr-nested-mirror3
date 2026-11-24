terraform {
  required_providers {
    scalr = {
      source = "registry.scalr.io/scalr/scalr"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 8.0"
    }
  }
}

variable "account_id" {
  type = string
}

variable "environment_id" {
  type = string
}

variable "google_project" {
  type = string
}

# Reading the environment fails without credentials from a Scalr provider configuration.
data "scalr_environment" "this" {
  id         = var.environment_id
  account_id = var.account_id
}

# Reading the client config fails without Google credentials, and its project is set only
# when GOOGLE_PROJECT is exported.
data "google_client_config" "this" {}

output "environment_name" {
  value = data.scalr_environment.this.name
}

output "google_project" {
  value = data.google_client_config.this.project
}
