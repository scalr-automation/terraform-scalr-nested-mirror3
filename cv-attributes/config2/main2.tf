resource "null_resource" "single" {
  count = 10
  triggers = {
    time = timestamp()
  }
}

output "time" {
  value = timestamp()
}
