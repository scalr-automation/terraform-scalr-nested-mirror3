include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../main.tf"
}

inputs = {
  module_name = "unit-b"
  resource_id = "resource-B"
}
