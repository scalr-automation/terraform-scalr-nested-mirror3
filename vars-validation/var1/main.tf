resource "random_pet" "example" {
  keepers = {
    string = var.string
  }
}


variable "num_in_range" {
  type    = number
  default = 1

  validation {
    condition     = var.num_in_range >= 1 && var.num_in_range <= 16 && floor(var.num_in_range) == var.num_in_range
    error_message = "Accepted values: 1-16."
  }
}
