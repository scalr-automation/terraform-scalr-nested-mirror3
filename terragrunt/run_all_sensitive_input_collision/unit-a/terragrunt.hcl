include "root" {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  token = "unit-a-secret-token"
}
