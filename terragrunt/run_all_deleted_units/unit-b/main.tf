resource "null_resource" "unit_b" {
  triggers = {
    value = "unit-b-resource"
  }
}

output "unit_b_output" {
  value = "unit-b"
}