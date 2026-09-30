module "iam_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group"
  version = "~> 6.8"

  name = "readonly"

  users = [for u in module.iam_user : u.name]

  enable_self_management_permissions = true
  policies = {
    ReadOnlyAccess = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  }

  tags = {
    Terraform   = "true"
    Environment = "sit"
  }
}