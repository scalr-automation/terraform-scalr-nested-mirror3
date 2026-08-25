variable "secret" {
  type      = string
  sensitive = true
}

resource "random_pet" "nested" {
  length = 1

  keepers = {
    secret = var.secret
  }
}

output "nested_secret" {
  value     = var.secret
  sensitive = true
}
