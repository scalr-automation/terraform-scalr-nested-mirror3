# Resource name starts with a digit — invalid identifier per terraform/tofu;
# parsed during init/get and reported as "Invalid resource name".
resource "null_resource" "1invalid" {
}
