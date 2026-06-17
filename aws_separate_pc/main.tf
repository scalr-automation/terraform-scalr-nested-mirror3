terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0" # < 5.0.0
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


variable "role_delegation_name" {
  type    = string
  default = "aws_iam_user_name_"
}

resource "aws_iam_role" "this" {
  name = var.role_delegation_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

output "this_name" {
  value = aws_iam_role.this.id
}