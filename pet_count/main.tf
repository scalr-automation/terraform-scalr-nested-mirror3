resource "random_pet" "pet" {
  count = 5
  keepers = {
    timestamp = timestamp()
  }
}
