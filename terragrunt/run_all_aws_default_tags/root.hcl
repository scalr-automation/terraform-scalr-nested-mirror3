# Fixture for SCALRCORE-39172: `default_tags` must reach every unit of a
# `terragrunt run-all`, not only the initiating unit.
#
# The provider block is generated into EVERY unit directory, so each unit has its
# own `provider "aws"` for Scalr's `scalr_override.tf.json` to merge into. A local
# backend is generated per unit so the fixture needs no remote state bucket.

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<-EOF
    terraform {
      backend "local" {}
    }
  EOF
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<-EOF
    provider "aws" {
      region = "us-east-1"
      default_tags {
        tags = {
          Owner    = "qa-team"
          UnitPath = "${path_relative_to_include()}"
        }
      }
    }
  EOF
}
