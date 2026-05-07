# References a module from a Git URL that doesn't exist. ``tofu init`` tries
# to clone the repo, gets a 404, and aborts with "Failed to download module"
# → plan_init_failed.
module "missing" {
  source = "git::https://github.com/scalr-automation/nonexistent-module-billable-runs-e2e.git"
}
