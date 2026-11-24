# tf-module-multi-pc

Module with tofu tests that read through two providers: a Scalr environment through the `scalr`
provider and the client config through the `google` provider. The tests pass only when the test
run gets the credentials of both provider configurations linked to the module test
configuration.

The Google provider has no `project` argument: the e2e test links a Google provider configuration
that exports its credentials as shell variables, so the project comes from `GOOGLE_PROJECT`.

The `account_id`, `environment_id` and `google_project` variables have no defaults: the e2e test
pushes a `e2e.auto.tfvars` with them into the pull request branch (Scalr ignores
`terraform.tfvars`).
