terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    scalr = {
      source = "scalr/scalr"
    }
    null = {
      source = "hashicorp/null"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "scalr" {
  hostname = var.scalr_hostname
  token    = var.scalr_token
}


data "aws_availability_zones" "available" {
  state = "available"
}

module "networking" {
  source = "./modules/aws/networking"

  name = var.vpc_name
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
  function_name       = var.lambda_function_name
  handler             = var.lambda_handler
  memory_size         = var.lambda_memory_size
  runtime             = var.lambda_runtime
  source_file         = "${path.module}/lambda_function.py"
  timeout             = var.lambda_timeout
}

module "api_gateway" {
  source = "./modules/aws/api-gateway"

  name                   = var.api_gateway_name
  environment            = var.api_gateway_environment
  additional_allowed_ips = []  # Will be set after agent pool is created
  allow_all_ingress      = var.allow_all_ingress
  lambda_invoke_arn      = module.lambda.invoke_arn
  lambda_function_name   = module.lambda.function_name
}

module "agent_pool" {
  source = "./modules/scalr/agent-pool"
  scalr_token_sub = var.scalr_token
  scalr_hostname  = var.scalr_hostname
}

module "ecs" {
  source            = "./modules/aws/ecs"
  vpc_id            = module.networking.vpc_id
  allow_all_ingress = var.allow_all_ingress
  limit_cpu         = var.ecs_limit_cpu
  limit_memory      = var.ecs_limit_memory
  image             = var.ecs_image
  cluster_name      = var.ecs_cluster_name
  task_name         = var.ecs_task_name
  scalr_url = module.agent_pool.scalr_url
  scalr_agent_token = module.agent_pool.agent_token

  security_group_name = var.ecs_security_group_name
}

# Configure the agent pool as serverless after all infrastructure is created
resource "terraform_data" "configure_agent_pool_serverless" {
  triggers_replace = [
    module.agent_pool.agent_pool_id,
    module.api_gateway.url,
    module.api_gateway.api_key
  ]

  provisioner "local-exec" {
    command = <<-EOT
      echo "Configuring agent pool ${module.agent_pool.agent_pool_id} as serverless..."
      echo "API Gateway URL: ${module.api_gateway.url}"
      echo "Scalr Hostname: ${var.scalr_hostname}"

      # Make the API call using the correct endpoint and format from working request
      curl -X PATCH "https://${var.scalr_hostname}/api/iacp/v3/agent-pools/${module.agent_pool.agent_pool_id}" \
        -H "Authorization: Bearer ${var.scalr_token}" \
        -H "Content-Type: application/vnd.api+json" \
        -d '{
          "data": {
            "id": "${module.agent_pool.agent_pool_id}",
            "type": "agent-pools",
            "attributes": {
              "webhook-enabled": true,
              "webhook-headers": [
                {
                  "name": "X-Api-Key",
                  "value": "${module.api_gateway.api_key}",
                  "sensitive": true
                }
              ],
              "webhook-url": "${module.api_gateway.url}"
            },
            "relationships": {
              "account": {"data": null},
              "agents": {"data": null},
              "environment": {"data": null},
              "environments": {"data": null},
              "workspaces": {"data": null}
            }
          }
        }' \
        -s && echo "Agent pool configured successfully" || (echo "Failed to configure agent pool" && exit 1)
    EOT
  }

  depends_on = [
    module.agent_pool,
    module.api_gateway,
    module.lambda,
    module.ecs,
    module.networking
  ]
}
