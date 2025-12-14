# Scalr Serverless Agent Infrastructure

## Overview
This Terraform module creates reusable AWS infrastructure for Scalr serverless agent pools. The infrastructure is created once and can be used by multiple agent pools simultaneously.

The setup uses AWS Lambda, API Gateway, and ECS Fargate to run Scalr agents on-demand. When Scalr needs to execute a run, it calls the webhook which triggers a Lambda function that starts an ECS Fargate task with the agent.

## Architecture
- **API Gateway**: Webhook endpoint for Scalr to trigger agent execution
- **Lambda**: Receives webhook calls and starts ECS tasks with agent pool credentials
- **ECS Fargate**: Runs the Scalr agent container on-demand
- **VPC**: Networking infrastructure for secure agent execution

## One-Time Setup

### 1. Deploy AWS Infrastructure
Create a workspace in Scalr from this repo and configure AWS provider. No Scalr-specific variables are needed.

Apply the configuration to create:
- VPC with public subnets
- ECS cluster
- Lambda function
- API Gateway with API key authentication

After successful deployment, note the outputs:
- `webhook_url`: API Gateway endpoint URL
- `api_key`: API key for webhook authentication (sensitive)

### 2. Configure Agent Pools

For each test or agent pool, configure it via Scalr API:

```bash
# 1. Create agent pool via Scalr API or UI
# 2. Get the agent pool ID and token
# 3. Configure the agent pool as serverless:

curl -X PATCH "https://${SCALR_HOSTNAME}/api/iacp/v3/agent-pools/${AGENT_POOL_ID}" \
  -H "Authorization: Bearer ${SCALR_TOKEN}" \
  -H "Content-Type: application/vnd.api+json" \
  -d '{
    "data": {
      "id": "'${AGENT_POOL_ID}'",
      "type": "agent-pools",
      "attributes": {
        "webhook-enabled": true,
        "webhook-headers": [
          {
            "name": "X-Api-Key",
            "value": "'${API_GATEWAY_KEY}'",
            "sensitive": true
          },
          {
            "name": "X-Scalr-Token",
            "value": "'${AGENT_POOL_TOKEN}'",
            "sensitive": true
          },
          {
            "name": "X-Scalr-Url",
            "value": "https://'${SCALR_HOSTNAME}'"
          }
        ],
        "webhook-url": "'${WEBHOOK_URL}'"
      }
    }
  }'
```

## How It Works

1. **Scalr triggers webhook**: When a run is queued, Scalr sends a POST request to the webhook URL with custom headers
2. **Lambda reads credentials**: Lambda extracts `X-Scalr-Token` and `X-Scalr-Url` from the webhook headers
3. **ECS task starts**: Lambda starts an ECS Fargate task, passing the credentials via container overrides
4. **Agent runs**: The Scalr agent connects to the specified Scalr instance and executes the run

## Benefits

- **Resource efficiency**: No need to create separate VPCs, Lambda functions, or ECS clusters for each agent pool
- **Cost optimization**: AWS resources are created once and reused, avoiding hitting AWS resource limits
- **Simplified management**: Single Terraform configuration manages all infrastructure
- **Test isolation**: Each agent pool gets unique credentials passed dynamically

## Project Structure
- `main.tf`: Root Terraform configuration
- `lambda_function.py`: Lambda function that reads credentials from headers and starts ECS tasks
- `variables.tf`: Input variables for customization
- `outputs.tf`: Outputs webhook URL and API key
- `modules/`: Terraform modules
  - `aws/api-gateway`: API Gateway configuration
  - `aws/lambda`: Lambda function configuration
  - `aws/ecs`: ECS Fargate task configuration
  - `aws/networking`: VPC and networking resources

## Customization

You can customize the infrastructure by setting variables:
- `aws_region`: AWS region (default: us-east-1)
- `ecs_limit_cpu`: CPU units for Fargate task (default: 1024)
- `ecs_limit_memory`: Memory in MB for Fargate task (default: 2048)
- `ecs_image`: Docker image for Scalr agent (default: scalr/agent:latest)
- `lambda_timeout`: Lambda timeout in seconds (default: 30)
- `allow_all_ingress`: Allow all ingress traffic (default: false) 
