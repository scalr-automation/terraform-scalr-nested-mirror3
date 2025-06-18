terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

# The missing resource that was referenced but didn't exist
resource "null_resource" "missing" {
  triggers = {
    time = timestamp()
  }
}

# This resource now references a valid, existing resource
resource "null_resource" "example" {
  triggers = {
    # This now references a resource that exists
    dependency = null_resource.missing.id
  }
}

output "example_output" {
  value = null_resource.example.id
}