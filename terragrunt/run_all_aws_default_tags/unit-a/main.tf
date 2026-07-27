terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

variable "unit_name" {
  type    = string
  default = "unit-a"
}

# Free resource — only ever planned, never applied, by the e2e test.
resource "aws_ssm_parameter" "unit" {
  name  = "/scalr-e2e/run-all-default-tags/${var.unit_name}"
  type  = "String"
  value = var.unit_name
}

output "parameter_name" {
  value = aws_ssm_parameter.unit.name
}
