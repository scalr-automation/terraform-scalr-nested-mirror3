terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

# This resource references a non-existent resource - will fail validate
resource "null_resource" "example" {
  triggers = {
    # This references a resource that doesn't exist
    dependency = null_resource.missing.id
  }
}

output "example_output" {
  value = null_resource.example.id
}
