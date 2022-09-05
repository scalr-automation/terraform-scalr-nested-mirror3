resource "random_pet" "example" {
  keepers = {
    string  = var.string
  }
}


variable "string" {
  default   = "qwerty"
  type = string
}
