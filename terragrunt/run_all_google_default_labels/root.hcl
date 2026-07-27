# Fixture for SCALRCORE-39172: `default_labels` must reach every unit of a
# `terragrunt run-all`, not only the initiating unit.
#
# The provider block is generated into EVERY unit directory, so each unit has its
# own `provider "google"` for Scalr's `scalr_override.tf.json` to merge into. A local
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
    provider "google" {
      project = "scalr-dev"
      region  = "us-central1"
      default_labels = {
        team      = "frontend"
        unit_path = "${replace(path_relative_to_include(), "/", "_")}"
      }
    }
  EOF
}
