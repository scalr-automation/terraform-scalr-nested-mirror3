terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "3.2.1"
    }
  }
}

resource "null_resource" "resource2" {
  provisioner "local-exec" {
    command = "echo $ENV"
    environment = {
      ENV = "Hello World!"
    }
  }
}