resource "terraform_data" "resource_to_update" {
  input = "v1"
}

resource "terraform_data" "resource_to_destroy" {
  input = "to be removed"
}
