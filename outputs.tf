data "aws_region" "current" {}

output "settings" {
  description = "A map of settings to supply to a Sym Permission Context."
  value = {
    cloud      = "aws"
    region     = data.aws_region.current.name
    role_arn   = aws_iam_role.this.arn
    account_id = data.aws_caller_identity.current.account_id
  }
}
