# Fixture for SCALRCORE-39172: `default_labels` must reach every unit of a
# `terragrunt run-all`, not only the initiating unit.
#
# The provider block is generated into EVERY unit directory, so each unit has its
# own `provider "google"` for Scalr's `scalr_override.tf.json` to merge into.
#
# `run-all` is only allowed on workspaces with state management disabled, and those
# forbid a local backend in any unit, so every unit gets its own key in the S3 bucket
# passed by the test through `BUCKET_NAME` (the test also passes the AWS credentials
# the backend needs — the resources under test stay Google-only).

locals {
  state_prefix = get_env("SCALR_WORKSPACE_ID")
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket  = get_env("BUCKET_NAME")
    key     = "${local.state_prefix}/${path_relative_to_include()}/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
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
