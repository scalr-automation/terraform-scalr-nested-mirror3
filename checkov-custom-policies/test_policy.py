import json
from checkov.common.models.enums import CheckCategories, CheckResult
from checkov.terraform.checks.resource.base_resource_check import BaseResourceCheck


class TestScalrPolicy(BaseResourceCheck):
    def __init__(self) -> None:
        name = "Scalr Custom Checkov Test Policy - Always fails to prove policy execution"
        id = "SCALR_TEST_001"
        supported_resources = ['aws_iam_policy']
        categories = [CheckCategories.IAM]
        super().__init__(name=name, id=id, categories=categories, supported_resources=supported_resources)

    def scan_resource_conf(self, conf):
        """
        Test policy that demonstrates custom Checkov integration is working.
        This policy intentionally fails to prove the custom policy is being executed.
        """
        # Always fail to demonstrate the policy is running
        self.evaluated_keys = ['policy']
        return CheckResult.FAILED


check = TestScalrPolicy()
