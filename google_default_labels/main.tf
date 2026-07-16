terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
  }
}

variable "label_source" {
  type    = string
  default = "dynamic"
}

locals {
  # Dynamically evaluated labels: a local map that the static HCL parser
  # cannot resolve on its own (SCALRCORE-38991).
  common_labels = {
    team        = "frontend"
    cost_center = "engineering"
  }
}

provider "google" {
  project = "scalr-dev"
  region  = "us-central1"
  # default_labels defined via Terraform expressions (locals + variable + merge())
  # rather than a static map, to exercise dynamic label resolution.
  default_labels = merge(local.common_labels, {
    source = var.label_source
  })
}

resource "google_storage_bucket" "labels_test" {
  name          = "scalr-e2e-default-labels-test"
  location      = "US"
  force_destroy = true

  labels = {
    app = "bucket-test"
  }
}
