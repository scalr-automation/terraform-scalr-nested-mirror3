terraform {
  required_providers {
    scalr = {
      source = "registry.scalr.io/scalr/scalr"
    }
  }
}

# Read attributes of the current run
data "scalr_current_run" "this" {}


# ----------------------------------------- #
resource "scalr_workspace" "workspace_unchanged" {
  name           = var.workspace_name_unchanged
  environment_id = data.scalr_current_run.this.environment_id
}

variable "workspace_name_unchanged" {
  type        = string
  description = "Set the name of the workspace only on the FIRST test step"
}

output "workspace_unchanged_id" {
  value = scalr_workspace.workspace_unchanged.id
}
# ----------------------------------------- #

# ----------------------------------------- #
resource "scalr_workspace" "workspace_to_update" {
  name           = var.workspace_name_to_update
  environment_id = data.scalr_current_run.this.environment_id
}

variable "workspace_name_to_update" {
  type        = string
  description = "Set the name of the workspace and change on every test step"
}

output "workspace_to_update_id" {
  value = scalr_workspace.workspace_to_update.id
}
# ----------------------------------------- #

# ----------------------------------------- #
resource "terraform_data" "run_var_input" {
  input = var.sensitive_run_var
}

variable "sensitive_run_var" {
  type        = string
  sensitive   = true
  description = "Set any value as a run variable on every test step"
}

output "run_var" {
  value     = terraform_data.run_var_input.output
  sensitive = true
}
# ----------------------------------------- #

# ----------------------------------------- #
resource "terraform_data" "scalr_var_input_unchanged" {
  input = var.sensitive_scalr_var_unchanged
}

variable "sensitive_scalr_var_unchanged" {
  type        = string
  sensitive   = true
  description = "Set any value as a Scalr variable on the FIRST test step only"
}

output "scalr_var_unchanged" {
  value     = terraform_data.scalr_var_input_unchanged.output
  sensitive = true
}
# ----------------------------------------- #

# ----------------------------------------- #
resource "terraform_data" "scalr_var_input_to_update" {
  input = var.sensitive_scalr_var_to_update
}

variable "sensitive_scalr_var_to_update" {
  type        = string
  sensitive   = true
  description = "Set any value as a Scalr variable and change on every test step"
}

output "scalr_var_to_update" {
  value     = terraform_data.scalr_var_input_to_update.output
  sensitive = true
}