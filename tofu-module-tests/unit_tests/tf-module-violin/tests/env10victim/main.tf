resource "terraform_data" "victim" {
  input = "env10mkmovementbankview"
  provisioner "local-exec" {
    when    = destroy
    command = "echo leave-errored-state; exit 1"
  }
}

output "marker" {
  value = "env10mkmovementbankview"
}
