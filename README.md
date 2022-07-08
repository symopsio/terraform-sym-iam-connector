# iam-connector

The `iam-connector` module provisions an IAM role that the [AWS IAM Strategy](https://docs.symops.com/docs/aws-iam) can use to escalate or de-escalate users via AWS IAM groups.

This `Connector` will provision a single IAM role for the Sym Runtime to use with a Strategy.

Only the supplied `runtime_role_arns` are trusted to assume this role.

```hcl
module "iam_connector" {
  source  = "symopsio/iam-connector/sym"
  version = ">= 1.0.0"

  environment = "sandbox"
  runtime_role_arns = [ var.runtime_role_arn ]
}
```

By default, the IAM connector can only modify groups that are within the `/sym/` path. You can can configure the connector to access other groups by changing the `group-config` setting:

```hcl
  group_config = [
    { path="/", name="EscalationGroups*" },
    { path="/other-path/", name="BreakGlass*" }
  ]
```
