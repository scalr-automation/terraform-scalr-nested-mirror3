terraform {
  required_providers {
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }
  }
}

import {
  to = time_static.imported
  id = "2020-02-12T06:36:13Z"
}

resource "time_static" "imported" {}
