resource "null_resource" "billable" {
  triggers = {
    always_run = timestamp()
  }
}
