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

resource "aws_iam_policy" "safe_policy_east" {
  name        = "safe-policy-east"
  description = "A policy that passes all Checkov checks - East"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = ["s3:GetObject"]
      Resource  = ["arn:aws:s3:::example-bucket-east/specific-path/*"]
      Condition = {
        IpAddress = {"aws:SourceIp" = ["192.0.2.0/24"]}
      }
    }]
  })
}
