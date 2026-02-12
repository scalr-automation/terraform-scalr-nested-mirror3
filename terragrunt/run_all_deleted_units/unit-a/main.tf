resource "null_resource" "unit_a" {
  triggers = {
    value = "unit-a-resource"
  }
}

output "unit_a_output" {
  value = "unit-a"
}