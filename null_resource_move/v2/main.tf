terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

moved {
  from = null_resource.old_name
  to   = null_resource.new_name
}

resource "null_resource" "new_name" {}
