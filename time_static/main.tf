terraform {
  required_providers {
    time = {
      source  = "hashicorp/time"
      version = var.time_version
    }
  }
}

variable "time_version" {
  description = "Time provider version"
  type        = string
}
