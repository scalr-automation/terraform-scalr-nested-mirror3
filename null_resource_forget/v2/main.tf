terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

removed {
  from = null_resource.to_forget

  lifecycle {
    destroy = false
  }
}
