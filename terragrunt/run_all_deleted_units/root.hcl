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
    bucket         = "scalr-e2e-tg-test"
    key            = "${local.state_prefix}/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
