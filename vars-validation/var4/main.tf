resource "random_password" "password" {
  count            = 1
  length           = var.long
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}


variable "long" {
  type        = string
  description = "What length?"
  default     = "88888888888888888"

  validation {
    condition     = length(var.long) <= 7
    error_message = "Err: prefix is too long."
  }
}
