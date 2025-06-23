variable "env" {
  default = "<Env1_name"
}

variable "ws" {
  default = "<WS1_name>"
}

variable "remote_hostname" {
  description = "Remote backend hostname"
  type        = string
}

data "terraform_remote_state" "state" {
  backend = "remote"

  config = {
    hostname     = var.remote_hostname
    organization = var.env
    workspaces = {
      name = var.ws
    }
  }
}

output "id" {
    value = data.terraform_remote_state.state.outputs.id_out
}
