variable "quokka_base" {
  type    = string
  default = "unset"
}

variable "quokka_prod" {
  type    = string
  default = "unset"
}

variable "quokka_shared" {
  type    = string
  default = "unset"
}

variable "quokka_extra" {
  type    = string
  default = "unset"
}

output "quokka_base" {
  value = var.quokka_base
}

output "quokka_prod" {
  value = var.quokka_prod
}

output "quokka_shared" {
  value = var.quokka_shared
}

output "quokka_extra" {
  value = var.quokka_extra
}
