terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }
  }
}

variable "secret" {
  type      = string
  sensitive = true
}

variable "resource_count" {
  type    = number
  default = 1
}

resource "random_pet" "app" {
  count     = var.resource_count
  length    = 2
  separator = "-"

  keepers = {
    secret = var.secret
    index  = count.index
  }
}

module "nested" {
  source = "./nested"
  secret = var.secret
}

output "app_names" {
  value = random_pet.app[*].id
}

output "app_secret" {
  value     = var.secret
  sensitive = true
}
