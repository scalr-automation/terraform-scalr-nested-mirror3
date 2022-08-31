resource "null_resource" "wait" {
  triggers = {
    run_id = var.run_id
  }
}

variable "run_id" {
  sensitive = true
}

output "output_run_id" {
  value = var.run_id
  sensitive = true
}
