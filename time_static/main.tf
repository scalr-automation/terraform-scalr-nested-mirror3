resource "time_static" "example1" {}

resource "time_static" "example2" {}

output "current_time" {
  value = time_static.example1.rfc3339
}
