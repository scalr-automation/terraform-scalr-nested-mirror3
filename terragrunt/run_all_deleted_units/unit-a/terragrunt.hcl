include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../main.tf"
}

inputs = {
  module_name = "unit-a"
  resource_id = "resource-A"
}
