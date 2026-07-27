# Fixture for SCALRCORE-39172: `default_tags` must reach every unit of a
# `terragrunt run-all`, not only the initiating unit.
#
# The provider block is generated into EVERY unit directory, so each unit has its
# own `provider "aws"` for Scalr's `scalr_override.tf.json` to merge into.
#
# `run-all` is only allowed on workspaces with state management disabled, and those
# forbid a local backend in any unit, so every unit gets its own key in the S3 bucket
# passed by the test through `BUCKET_NAME`.

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
