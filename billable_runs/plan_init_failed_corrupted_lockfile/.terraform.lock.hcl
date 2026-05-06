# Deliberately corrupted lockfile — the trailing block is missing its
# closing brace, so terraform/tofu fails with "invalid HCL: ... Unclosed
# configuration block", which surfaces as "Failed to read lock file" and
# maps to plan_init_failed.
provider "registry.terraform.io/hashicorp/null" {
  version = "3.2.4"
  hashes = [
    "h1:Z2lp4dxsZSGJpJVGsdKBzCfxKOX0pAVAWY1+VoKgVNo=",
