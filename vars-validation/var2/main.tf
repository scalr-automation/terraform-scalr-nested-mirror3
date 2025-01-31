resource "random_pet" "example" {
  keepers = {
    string = var.string
  }
}


variable "rules" {
  type = list(object({
    name   = string
    access = string
  }))
  default = [
    {
      name   = "pet"
      access = "Deny"
    }
  ]

  validation {
    condition = contains(["Allow", "Deny"], var.rules[0].access)
    error_message = "Invalid access, can be either Allow or Deny."
  }

  validation {
    condition = contains(["cat", "pet"], var.rules[0].name)
    error_message = "Invalid name, can be either cat or pet."
  }
}
