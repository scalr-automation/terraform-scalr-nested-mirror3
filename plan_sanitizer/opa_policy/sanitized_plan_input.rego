package terraform

# Scalr evaluates `data.terraform.deny` with
# input = {"tfplan": <JSON plan>, "tfrun": {...}}.
#
# With the account quota `sanitize-policy-input` enabled, `tfplan` is the sanitized
# plan and every message below carries "(sensitive)[<hmac>]". With the quota disabled
# they carry the raw variable value, which is what AD-02 asserts on.
#
# Enforcement level is advisory (see scalr-policy.hcl) so the run is not blocked and
# the messages still land in the policy check output.

deny[msg] {
    value := input.tfplan.variables.secret.value
    msg := sprintf("policy input variable secret = %s", [value])
}

deny[msg] {
    change := input.tfplan.resource_changes[_]
    value := change.change.after.keepers.secret
    msg := sprintf("policy input %s keepers.secret = %s", [change.address, value])
}

deny[msg] {
    value := input.tfplan.output_changes.app_secret.after
    msg := sprintf("policy input output app_secret = %s", [value])
}
