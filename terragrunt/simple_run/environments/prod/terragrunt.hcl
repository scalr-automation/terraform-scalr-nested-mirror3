#CONFIGURATION FOR SIMPLE NULL RESOURCE - PROD

terraform {
  source = "../../modules/null_resource"
}

inputs = {
  environment = "prod"
}
