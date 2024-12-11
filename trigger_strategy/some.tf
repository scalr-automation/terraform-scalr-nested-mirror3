resource "random_pet" "data" {
  input = timestamp()
  triggers_replace = timestamp()
}