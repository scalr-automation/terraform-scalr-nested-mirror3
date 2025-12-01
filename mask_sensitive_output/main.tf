variable "test_sensitive_value" {
  type      = string
  sensitive = true
  default   = "TEST_SECRET_VALUE_123"
}

# Dummy local to simulate processing
locals {
  processed_value = "${var.test_sensitive_value}-processed"
}

output "raw_sensitive_value" {
  value     = var.test_sensitive_value
  sensitive = true   # This is what Scalr normally masks
}

output "processed_sensitive_value" {
  value     = local.processed_value
  sensitive = true
}
