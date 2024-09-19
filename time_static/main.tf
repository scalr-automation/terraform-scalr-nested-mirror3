terraform {
  required_providers {
    time = {
      source  = "hashicorp/time"
      version = "0.12.0"
    }
  }
}

resource "tls_private_key" "ecdsa-p384-example" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "time_static" "example" {}
