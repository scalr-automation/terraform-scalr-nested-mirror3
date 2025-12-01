variable "sensitive_tf_var" {
  type      = string
  sensitive = true
}

resource "null_resource" "test" {
  provisioner "local-exec" {
    command = "echo SHELL_VAR=$SENSITIVE_SHELL_VAR && echo TF_VAR=${var.sensitive_tf_var}"
  }
}
