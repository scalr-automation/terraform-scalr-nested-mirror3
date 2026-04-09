module "example" {
  source = "oci://registry-1.docker.io/scalrtestuser/scalr-docker-test?tag=module-smoke-v2"
}

output "module_loaded" {
  value = true
}