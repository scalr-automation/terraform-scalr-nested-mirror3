resource "null_resource" "demo" {
  for_each = local.cfgs

  provider = null.cfg[each.key]

  triggers = {
    message = each.value
  }
}
