resource "null_resource" "tfvars_folder" {
  triggers = {
    trigger = var.string
  }
}

variable "string" {
  type = string
  description = "Set path to varfile with value on workspace creation"
}

resource "null_resource" "tfvars2_folder" {
  triggers = {
    trigger = var.string2
  }
}

variable "string2" {
  type = string
}