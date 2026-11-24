run "scalr_credentials_injected" {
  command = plan

  assert {
    condition     = data.scalr_environment.this.id == var.environment_id
    error_message = "Expected the scalr provider to read the environment with the injected credentials"
  }
}

run "google_credentials_injected" {
  command = plan

  assert {
    condition     = data.google_client_config.this.project == var.google_project
    error_message = "Expected the google provider to get the project from the exported GOOGLE_PROJECT"
  }
}
