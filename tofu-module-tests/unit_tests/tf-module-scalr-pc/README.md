# tf-module-scalr-pc

Module with tofu tests that read a Scalr environment through the `scalr` provider. The tests pass
only when the test run gets credentials from a provider configuration attached to the module test
configuration.

The `account_id` and `environment_id` variables have no defaults: the e2e test pushes a
`e2e.auto.tfvars` with them into the pull request branch (Scalr ignores
`terraform.tfvars`).
