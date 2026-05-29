resource "null_resource" "no_readme" {
  provisioner "local-exec" {
    command = "echo $ENV"
    environment = {
      ENV = "Submodule without readme"
    }
 }
}
