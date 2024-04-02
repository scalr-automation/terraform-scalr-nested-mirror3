resource "random_pet" "pet" {
  count = 5
  keepers = {
    timestamp = timestamp()
  }
}

variable "tf_version" {
  description = "required terraform version"
  default = "~> 0.15.1"
}

terraform {
  required_version = var.tf_version
}
