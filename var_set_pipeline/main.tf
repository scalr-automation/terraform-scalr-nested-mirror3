variable "vs_tf_var" {
  type        = string
  description = "Terraform variable whose effective value is resolved by the run pipeline."
}

output "vs_tf_var" {
  value = var.vs_tf_var
}
