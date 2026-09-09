# Fixture for SCALRCORE-39810 bug #6: configuration mixed between Terragrunt units.
#
# unit-a and unit-b both declare an input variable named "token", but only unit-a marks
# it sensitive. Before the fix, the run-details Inputs tab matched configuration by input
# name only (not by unit path), so whichever unit's dispatch finished last decided the
# sensitive state shown for BOTH units' "token" row — exposing unit-a's secret in plain
# text, or masking unit-b's non-secret value, depending on load order.
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
    }
  EOF
}
