#CONFIGURATION FOR SIMPLE NULL RESOURCE - DEV

terraform {
  source = "../../modules/null_resource"
}

inputs = {
  environment = "dev"
}
