#SIMPLE NULL RESOURCE CONFIGURATION
resource "null_resource" "example" {
  triggers = {
    environment = var.environment
    message     = "This is the ${var.environment} environment."
  }

  provisioner "local-exec" {
    command = "echo Hello from ${var.environment}!"
  }
}

output "ensure_env" {
  value= "Hello from ${var.environment}!"
}