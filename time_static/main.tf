terraform {
  required_providers {
    time = {
      source = "hashicorp/time"
      version = "${var.time_version}"
    }
  }
}

resource "time_static" "example" {}
