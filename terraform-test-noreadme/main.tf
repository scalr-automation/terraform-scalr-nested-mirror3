resource "random_pet" "root" {
  keepers = {
    timestamp = timestamp()
  }
}
