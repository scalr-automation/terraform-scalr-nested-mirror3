output "messages" {
  value = {
    for k, r in null_resource.demo :
    k => r.triggers.message
  }
}
