resource "aws_iam_role" "this" {
  name = "SymIAM${title(var.environment)}"
  path = "/sym/"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        AWS = var.runtime_role_arns
      }
    }]
    Version = "2012-10-17"
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "iam" {
  policy_arn = aws_iam_policy.iam.arn
  role       = aws_iam_role.this.name
}

data "aws_caller_identity" "current" {}

locals {
  group_arn_prefix = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:group"
  group_resources  = [for config in var.group_config : "\"${local.group_arn_prefix}${config["path"]}${config["name"]}\""]
}


resource "aws_iam_policy" "iam" {
  name = "SymIAM${title(var.environment)}"
  path = "/sym/"

  description = "Allows Sym to manage IAM Groups"
  policy      = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:AddUserToGroup",
                "iam:RemoveUserFromGroup"
            ],
            "Resource": [ ${join(",", local.group_resources)} ]
        },
        {
            "Action": [
                "iam:GetUser"
            ],
            "Effect": "Allow",
            "Resource": [
                "*"
            ]
        }
    ]
}
EOT
}
