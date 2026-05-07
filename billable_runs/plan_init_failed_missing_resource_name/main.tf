# Resource block missing the second label (name) — terraform/tofu errors with
# "Missing name for resource" during parse, which surfaces as a tofu get failure.
resource "null_resource" {
}
