terraform {
  required_version = ">= 1.2.0"
}

variable "run_id" {
  default = "run_id_9"
}

variable "sleep_time" {
  default = 100
}

resource "random_integer" "timeout" {
  min = 50
  max = 60

  keepers = {
    run_id = var.run_id
  }
}



resource "null_resource" "env_vars" {
  triggers = {
    run_id = var.run_id
  }
  provisioner "local-exec" {
    command = "env"
  }
}

output "very_long" {
  value = "Webhook. Lorem dfipsusdm dolor sit ameывt, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"  
}

output "senc_out" {
  value = "secret data"
  description = "my sensitive output"
  sensitive = true
}

output "output_run_id" {
  value = var.run_id
}

