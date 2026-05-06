variable "required_no_default" {
  type = string
}

resource "null_resource" "x" {
  triggers = {
    value = var.required_no_default
  }
}
