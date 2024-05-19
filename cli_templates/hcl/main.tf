# map (object)

variable "map_object" {
  type = map(object({
    cidr     = string
    zone     = string
    tags     = map(string)
    cidr_app = string
    gw_app   = string
    cidr_db  = string
    gw_db    = string
  }))
}

resource "null_resource" "map_object" {
  provisioner "local-exec" {
    command = "echo ${var.map_object.AIMS.cidr}"
  }
  triggers = var.map_object.AIMS.tags
}

# number, bool and string

variable "number" {
  type = number
}

variable "bool" {
  type = bool
}

variable "string" {
  type = string
}

resource "random_password" "number_bool_string" {
  length           = var.number
  special          = var.bool
  override_special = var.string
}

# list(object)

variable "list" {
  type = list(object({
    password-length = number
    password-special = bool
    password-override-special = string
  }))
}

resource "random_password" "list_object_per_attribute_usage" {
  length           = var.list[0].password-length
  special          = var.list[0].password-special
  override_special = var.list[0].password-override-special
}

# list(string)

variable "list_string" {
  type = list(string)
}

resource "random_shuffle" "name" {
  input = var.list_string
}

# untyped list, nested object, referencing the variable as a whole

variable "list_untyped" {}

variable "nested_object" {
  type = object({
    id = string
    labels = map(string)
    size = number
  })
}

resource "terraform_data" "list_untyped_nested_object" {
  input = var.list_untyped
  triggers_replace  = var.nested_object
}

# object with optional attribute and attribute with a default value 

variable "object_with_optional_attribute" {
  type = object({
    a = string                
    b = optional(string)      
    c = optional(number, 127)
  })
}

resource "terraform_data" "object_with_optional_attribute" {
  input = var.object_with_optional_attribute
  triggers_replace = var.object_with_optional_attribute
}

# nullable variable as a trigger

variable "nullable" {
  type     = string
  nullable = true
  default  = null
}

resource "null_resource" "nullable_trigger" {
  triggers = {
    example_variable = var.nullable != null ? var.nullable : "default_value"
  }
}

# variable with type any

variable "type_any" {
  type = any
}

resource "terraform_data" "type_any" {
  input = var.type_any
  triggers_replace = var.type_any
}

# map with non-literal key

variable "key-name" {
  type        = string
}

locals {
  map_with_non_literal_key = {
    stable = "value1"
    (var.key-name) = "value2"
  }
}

resource "null_resource" "triggered-by-non-literal-map" {
  triggers = local.map_with_non_literal_key
}
