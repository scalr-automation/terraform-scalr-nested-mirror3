resource "random_pet" "pet" {
  count = 5
  keepers = {
    timestamp = timestamp()
  }
}

terraform {
  required_version = "< 1.4.6, > 1.5.7"
}
