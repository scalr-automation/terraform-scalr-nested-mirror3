resource "terraform_data" "some" {
  triggers_replace = "conflicting-change"
}