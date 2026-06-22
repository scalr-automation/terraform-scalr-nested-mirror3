terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
  }
}

provider "google" {
  project = "scalr-dev"
  region  = "us-central1"
  default_labels = {
    team = "frontend"
  }
}

resource "google_storage_bucket" "labels_test" {
  name     = "scalr-e2e-default-labels-test"
  location = "US"
}
