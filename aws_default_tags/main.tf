provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Project = "test-project"
      Owner = "qa-team"
      }
    }
  }

resource "aws_s3_bucket" "test" {
  bucket = "scalr-test"
}
