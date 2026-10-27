resource "terraform_data" "some" {
  triggers_replace = timestamp()
}