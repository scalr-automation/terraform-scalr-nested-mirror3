terraform {
  required_providers {
    time = {
      source = "hashicorp/time"
      version = var.version
    }
  }
}

resource "time_static" "example" {}
