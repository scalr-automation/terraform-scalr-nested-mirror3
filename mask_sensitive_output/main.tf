variable "sensitive_tf_var" {
  type = string
}

# Output the terraform variable
output "sensitive_tf_var_output" {
  value = var.sensitive_tf_var
  sensitive = true
}
