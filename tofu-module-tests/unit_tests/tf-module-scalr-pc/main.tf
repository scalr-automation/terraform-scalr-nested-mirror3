terraform {
  required_providers {
    scalr = {
      source = "registry.scalr.io/scalr/scalr"
    }
  }
}

variable "account_id" {
  type = string
}

variable "environment_id" {
  type = string
}

# Reading the environment fails without credentials from a provider configuration.
data "scalr_environment" "this" {
  id         = var.environment_id
  account_id = var.account_id
}

output "environment_name" {
  value = data.scalr_environment.this.name
}
