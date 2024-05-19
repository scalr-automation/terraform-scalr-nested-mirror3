variable "not-set-hcl" {
  type     = string
  default = null
}

variable "not-set-non-hcl" {
  type     = string
  default = null
}

variable "null-hcl" {
  type     = string
  default = null
}

variable "null-non-hcl" {
  type     = string
  default = null
}

variable "null-default" {
  type     = string
  default = null
}

variable "null-varfile" {
  type     = string
  default = null
}

variable "empty-string-varfile" {
  type     = string
  default = null
}

####
# RESOURCES
####

resource "null_resource" "not-set-hcl" {
  triggers = {
    trigger = var.not-set-hcl
  }
}

resource "null_resource" "not-set-non-hcl" {
  triggers = {
    trigger = var.not-set-non-hcl
  }
}

resource "null_resource" "null-hcl" {
  triggers = {
    trigger = var.null-hcl
  }
}

resource "null_resource" "null-non-hcl" {
  triggers = {
    trigger = var.null-non-hcl
  }
}

resource "null_resource" "null-default" {
  triggers = {
    trigger = var.null-default
  }
}

resource "null_resource" "null-varfile" {
  triggers = {
    trigger = var.null-varfile
  }
}

resource "null_resource" "empty-string-varfile" {
  triggers = {
    trigger = var.empty-string-varfile
  }
}
