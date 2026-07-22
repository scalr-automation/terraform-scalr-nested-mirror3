# Combines several init-time errors so terraform/tofu emits multiple
# "│ Error:" blocks at once:
#   * Invalid version constraint in a `required_providers` entry
#   * Missing name for resource
#   * Invalid resource name
#
# The version constraint lives in `required_providers` (not the core
# `required_version`): OpenTofu >= 1.12 silently accepts a malformed
# `required_version`, so putting it there would drop the error on newer
# versions. A malformed `required_providers` version constraint is still
# validated, so all three errors surface on both older and newer tofu.
#
# Used by the test_run_is_billable e2e to validate that runs failing with
# multiple unrelated init errors still map to plan_init_failed and are
# non-billable.

terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "not-a-valid-constraint"
    }
  }
}

resource "null_resource" {}

resource "null_resource" "1invalid" {}
