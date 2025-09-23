# Scalr Serverless Runner

## Overview
This project sets up a serverless infrastructure using AWS Lambda, API Gateway, and ECS Fargate. It allows you to trigger Fargate tasks via an API Gateway endpoint secured with an API key.

## Setup
1. Create a Workspace in Scalr from this repo and configure the following variables in the Workspace:
   - `scalr_hostname`: The hostname of your Scalr instance (e.g., `your-instance.scalr.dev`)
   - `scalr_token`: Your Scalr API token
2. Create AWS Provider Configuration and link it to the workspace

2. Apply a run in this workspace

   This will automatically:
   - Create the AWS infrastructure (API Gateway, Lambda, ECS)
   - Create the Scalr agent pool
   - Configure the agent pool as serverless via API call

## Usage
1. Create a workspace with test resources
2. Link it to the created agent pool
3. Queue a run and observe that it executes on serverless agents

## Project Structure
- `main.tf`: Root Terraform configuration
- `lambda_function.py`: AWS Lambda function code
- `modules/`: Terraform modules
  - `aws/api-gateway`: API Gateway configuration
  - `aws/lambda`: Lambda function configuration
  - `aws/ecs`: ECS Fargate task configuration
  - `aws/networking`: VPC and networking resources
  - `scalr/agent-pool`: Scalr agent pool configuration

## License
[Specify your license here] 