locals {
  cfgs = var.instances
}

provider "null" {
  alias    = "cfg"
  for_each = local.cfgs
}
