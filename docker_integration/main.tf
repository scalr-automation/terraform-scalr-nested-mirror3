terraform {
  required_version = ">= 1.10.0"
}

module "example" {
  source = "oci://registry-1.docker.io/scalrtestuser/scalr-docker-test?tag=module-smoke-v2"
}

output "module_message" {
  value = module.example.module_message
}