resource "random_pet" "pet" {
  count = 5
  keepers = {
    timestamp = timestamp()
  }
}

terraform {
  required_version = "~> 1.5"
}
