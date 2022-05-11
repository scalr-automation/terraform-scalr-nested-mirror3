resource "random_pet" "run_from_vcs" {
  keepers = {
    timestamp = timestamp()
  }
}
