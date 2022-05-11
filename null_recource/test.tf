resource "null_resource" "resource1" {
  provisioner "local-exec" {
    command = "env"
    environment = {
      ENV = "Hello World!"
    }
  }
  
  triggers = {
    test = format("example+%s", timestamp())
  }
}
