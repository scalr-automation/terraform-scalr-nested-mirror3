terraform {
  required_providers {
    time = {
      source = "hashicorp/time"
      version = "0.12.0"
    }
  }
}

resource "time_static" "example" {}
