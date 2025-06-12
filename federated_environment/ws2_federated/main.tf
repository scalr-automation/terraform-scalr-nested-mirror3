variable "env" {
  default = "<Env1_name>"
}

variable "ws" {
  default = "<WS1_name>"
}

variable "leatherclub_address" {
  default = "<hostname_address>"
}

data "terraform_remote_state" "state" {
  backend = "remote"

  config = {
    hostname = var.leatherclub_address
    organization = var.env
    workspaces = {
      name = var.ws
    }
  }
}


output "id" {
    value = data.terraform_remote_state.state.outputs.id_out
}