output "agent_pool_id" {
  description = "The ID of the Scalr agent pool"
  value       = scalr_agent_pool.webhook.id
}

output "agent_token" {
  description = "The token for the Scalr agent"
  value       = scalr_agent_pool_token.webhook.token
  sensitive   = true
}

output "allowed_ips" {
  description = "List of allowed IPs from Scalr allowlist"
  value       = local.scalr_ips
}
