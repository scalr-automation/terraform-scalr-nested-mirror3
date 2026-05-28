# Combines several init-time errors so terraform/tofu emits multiple
# "│ Error:" blocks at once:
#   * Invalid version constraint in `required_version`
#   * Missing name for resource
#   * Invalid resource name
#
# Used by the test_run_is_billable e2e to validate that runs failing with
# multiple unrelated init errors still map to plan_init_failed and are
# non-billable.

terraform {
  required_version = "not-a-valid-constraint"
}

resource "null_resource" {}

resource "null_resource" "1invalid" {}
