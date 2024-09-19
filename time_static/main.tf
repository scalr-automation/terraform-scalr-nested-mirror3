locals {
  time_provider_version = var.time_version
}

terraform {
  required_providers {
    time = {
      source  = "hashicorp/time"
      version = local.time_provider_version
    }
  }
}

resource "time_static" "example" {}
