terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}


data "aws_availability_zones" "available" {
  state = "available"
}

resource "random_id" "deployment" {
  byte_length = 4
}

locals {
  resource_prefix = "e2e-${random_id.deployment.hex}"
}

module "networking" {
  source = "./modules/aws/networking"

  name = "${local.resource_prefix}-${var.vpc_name}"
  cidr = "10.0.0.0/16"
  azs = slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
}

module "lambda" {
  source = "./modules/aws/lambda"

  subnet_ids          = module.networking.public_subnet_ids
  cluster_name        = module.ecs.cluster_name
  task_definition_arn = module.ecs.task_definition_arn
  security_group_id   = module.ecs.security_group_id
  container_name      = "${local.resource_prefix}-${var.ecs_task_name}"
  function_name       = "${local.resource_prefix}-${var.lambda_function_name}"
  handler             = var.lambda_handler
  memory_size         = var.lambda_memory_size
  runtime             = var.lambda_runtime
  source_file         = "${path.module}/lambda_function.py"
  timeout             = var.lambda_timeout
}

module "api_gateway" {
  source = "./modules/aws/api-gateway"

  name                   = "${local.resource_prefix}-${var.api_gateway_name}"
  environment            = var.api_gateway_environment
  additional_allowed_ips = []
  allow_all_ingress      = var.allow_all_ingress
  lambda_invoke_arn      = module.lambda.invoke_arn
  lambda_function_name   = module.lambda.function_name
}

module "ecs" {
  source            = "./modules/aws/ecs"
  vpc_id            = module.networking.vpc_id
  allow_all_ingress = var.allow_all_ingress
  limit_cpu         = var.ecs_limit_cpu
  limit_memory      = var.ecs_limit_memory
  image             = var.ecs_image
  cluster_name      = "${local.resource_prefix}-${var.ecs_cluster_name}"
  task_name         = "${local.resource_prefix}-${var.ecs_task_name}"
  security_group_name = "${local.resource_prefix}-${var.ecs_security_group_name}"
}
