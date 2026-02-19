variable "module_name" {
  description = "The name of the module"
  default = "test_module_name"
  type        = string
}

variable "resource_id" {
  description = "A unique identifier for the resource"
  type        = string
  default = "test_resource_id"
}

resource "null_resource" "random_sleep_example_shuf" {
  triggers = {
    force_recreation = timestamp()
  }
  provisioner "local-exec" {
    command = "sleep $(shuf -i 1-20 -n 1)"
  }
}

output "resource_output" {
  value = {
    module_name = var.module_name
    resource_id = var.resource_id
  }
}
