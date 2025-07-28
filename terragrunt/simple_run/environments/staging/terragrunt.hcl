#CONFIGURATION FOR SIMPLE NULL RESOURCE - STAGING

terraform {
  source = "../../modules/null_resource"
}

inputs = {
  environment = "staging"
}
