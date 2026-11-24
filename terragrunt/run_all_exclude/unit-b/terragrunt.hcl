include "root" {
  path = find_in_parent_folders("root.hcl")
}

exclude {
  if      = get_env("ENABLE_DR", "false") != "true"
  actions = ["all"]
}
