resource "random_pet" "example" {
  keepers = {
    string = var.string
  }
}


variable "semv1" {
  default = "10.57.123"

  validation {
    error_message = "Must be valid semantic version."
    condition = can(regex("^(0|[1-9]\\d*)\\.(0|[1-9]\\d*)\\.(0|[1-9]\\d*)(?:-((?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\\.(?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?$", var.semv1))
  }
}
