variable "time_version" {
  description = "Time provider version"
  type        = string
  default     = ""
}

terraform {
  required_providers {
    time = {
      source  = "hashicorp/time"
      # If the variable is set, use it; otherwise, use the default version "0.12.0"
      version = var.time_version != "" ? var.time_version : "0.12.0"
    }
  }
}

resource "time_static" "example" {}
