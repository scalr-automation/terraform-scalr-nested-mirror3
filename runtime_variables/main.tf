resource "random_password" "password" {
  count = var.pass_count
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

variable "pass_count"{
  type = string
  default = 1
}

resource "random_pet" "pet" {
  count = 1
  prefix = var.prefix
  separator = "."
  length = 1
}

variable "prefix" {
  type = string
}
