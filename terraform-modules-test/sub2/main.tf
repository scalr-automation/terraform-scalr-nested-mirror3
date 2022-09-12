variable "run_id" {
  default = "run_id_2"
  sensitive = true
}

resource "null_resource" "rec2" {
  count = 30
  triggers = {
    run_id = var.run_id
  }
  provisioner "local-exec" {
    command = "env"
  }
}
