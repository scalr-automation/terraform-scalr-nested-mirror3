output "webhook_url" {
  description = "The URL of the API Gateway endpoint to configure in agent pool webhook-url"
  value       = module.api_gateway.url
}

output "api_key" {
  description = "The API key for authentication to use in agent pool webhook-headers (X-Api-Key)"
  value       = module.api_gateway.api_key
  sensitive   = true
}
