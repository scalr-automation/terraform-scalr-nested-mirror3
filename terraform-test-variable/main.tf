resource "random_pet" "example" {
  keepers = {
    string  = var.version_02
  }
}


variable "version_02" {
  type = string
}
