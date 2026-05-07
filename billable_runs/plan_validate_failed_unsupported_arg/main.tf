resource "null_resource" "example" {
  # `unsupported_argument` is not a valid attribute on null_resource — terraform
  # validate fails with "Unsupported argument", which maps to plan_validate_failed.
  unsupported_argument = "trigger validate failure on purpose"
}
