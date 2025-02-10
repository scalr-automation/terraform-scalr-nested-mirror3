resource "null_resource" "single" {
  count = 10
  triggers = {
    time = timestamp()
  }
}

resource "random_pet" "pet" {
  count     = 10
  prefix    = var.prefix
  separator = "."
  length    = 1
}

variable "prefix" {
  default = "Sr"
  type    = string
}