resource "random_pet" "pet" {
  count = var.exec_count
  keepers = {
    timestamp = timestamp()
  }
}
