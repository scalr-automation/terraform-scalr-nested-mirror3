include "root" {
  path = find_in_parent_folders("root.hcl")
}

# `unit-a` lives outside unit-b's working directory, so it is only pulled into the
# run-all graph when `include-external-dependencies` is enabled on the workspace.
dependency "unit_a" {
  config_path = "../unit-a"

  mock_outputs = {
    bucket_name = "scalr-e2e-run-all-labels-unit-a"
  }
}

inputs = {
  unit_name = "unit-b"
  upstream  = dependency.unit_a.outputs.bucket_name
}
