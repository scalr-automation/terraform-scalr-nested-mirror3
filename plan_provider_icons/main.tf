terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
    archive = {
      source = "hashicorp/archive"
    }
  }
}

# hashicorp/null: the plan view shows the HashiCorp icon
resource "null_resource" "app" {
  count = 2
}

# terraform.io/builtin/terraform: the plan view shows the Terraform icon (needs Terraform 1.4+)
resource "terraform_data" "config" {
  input = "v1"
}

# hashicorp/archive has no icon of its own: the plan view falls back to the custom provider icon
resource "archive_file" "bundle" {
  type                    = "zip"
  output_path             = "${path.module}/bundle.zip"
  source_content          = "hello"
  source_content_filename = "hello.txt"
}
