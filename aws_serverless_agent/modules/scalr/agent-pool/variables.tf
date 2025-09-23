variable "agent_pool_name" {
  description = "Name of the agent pool"
  type        = string
  default     = "webhook-agent-pool"
}

variable "scalr_hostname" {
  type = string
  description = "host name of Scalr instance"
}

variable "scalr_token_sub" {
  type = string
  description = "Scalr token"
}

variable "api_gateway_url" {
  type = string
  description = "API Gateway URL for webhook"
  default = ""
}

variable "api_key" {
  type = string
  description = "API key for webhook authentication"
  default = ""
  sensitive = true
}
