run "provider_credentials_injected" {
  command = plan

  assert {
    condition     = data.scalr_environment.this.id == var.environment_id
    error_message = "Expected the scalr provider to read the environment with the injected credentials"
  }
}
