resource "random_id" "my_id" {
  count = 1
  byte_length = 4
  prefix = var.prefix
}

variable "prefix"{
  type = string
  default = "mr"
}

output "id_out" {
  value = random_id.my_id[0].id
}
