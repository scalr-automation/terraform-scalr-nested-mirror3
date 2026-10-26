resource "terraform_data" "data" {
  input = timestamp()
  triggers_replace = timestamp()
}