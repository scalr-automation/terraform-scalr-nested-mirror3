terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

import {
  to   = null_resource.imported
  id   = "null-resource-external-id"
}

resource "null_resource" "imported" {}
