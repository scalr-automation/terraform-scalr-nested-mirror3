resource "null_resource" "x" {
  triggers = {
    always_run = timestamp()
  }
}
