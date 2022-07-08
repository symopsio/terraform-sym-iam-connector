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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | An environment qualifier for the resources this module creates, to support a Terraform SDLC. | `string` | n/a | yes |
| <a name="input_group_config"></a> [group\_config](#input\_group\_config) | List of group resources the connector can modify. Each group resource is an object that contains a path and a name property. Both the path and name can contain wildcards. | <pre>list(object(<br>    { path = string, name = string }<br>  ))</pre> | <pre>[<br>  {<br>    "name": "*",<br>    "path": "/sym/"<br>  }<br>]</pre> | no |
| <a name="input_runtime_role_arns"></a> [runtime\_role\_arns](#input\_runtime\_role\_arns) | ARNs of the runtime connector roles that are trusted to assume the SSO role. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_settings"></a> [settings](#output\_settings) | A map of settings to supply to a Sym Permission Context. |
<!-- END_TF_DOCS -->