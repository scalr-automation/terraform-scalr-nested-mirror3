resource "random_pet" "example" {
  keepers = {
    string  = var.version_01
  }
}


variable "version_01" {
  type = string
}
