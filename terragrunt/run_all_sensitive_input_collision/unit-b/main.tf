terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

variable "token" {
  type = string
}

# Free resource — only ever planned, never applied, by the e2e test.
resource "aws_ssm_parameter" "unit" {
  name  = "/scalr-e2e/run-all-sensitive-collision/unit-b"
  type  = "String"
  value = var.token
}

output "parameter_name" {
  value = aws_ssm_parameter.unit.name
}
