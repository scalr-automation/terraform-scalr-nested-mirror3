include "root" {
  path = find_in_parent_folders("root.hcl")
}

# `unit-a` lives outside unit-b's working directory, so it is only pulled into the
# run-all graph when `include-external-dependencies` is enabled on the workspace.
dependency "unit_a" {
  config_path = "../unit-a"

  mock_outputs                            = {
    parameter_name = "/scalr-e2e/run-all-default-tags/unit-a"
  }
}

inputs = {
  unit_name = "unit-b"
  upstream  = dependency.unit_a.outputs.parameter_name
}
