terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

# true: the apply writes local_file on the runner. Every run starts on a fresh runner, so the next
# refresh finds the file gone and reports drift. The workspace drifts again after each check
# without anyone touching it.
# false: only terraform_data is managed, so drift checks report no drift.
variable "with_drift" {
  type    = bool
  default = true
}

resource "terraform_data" "stable" {
  input = "no drift"
}

resource "local_file" "ephemeral" {
  count    = var.with_drift ? 1 : 0
  filename = "${path.module}/drift.txt"
  content  = "Written by the apply run and gone on the next runner."
}
