resource "null_resource" "single" {
count= 1
  triggers= {
    time= timestamp()
  }
}

output  "time" {
  value = timestamp()

}