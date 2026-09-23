module "iam_account" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-account"
  version = "~> 6.8"

  account_alias = "test-account"

  max_password_age               = 90
  minimum_password_length        = 24
  require_uppercase_characters   = true
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  password_reuse_prevention      = 3
  allow_users_to_change_password = true
}

module "iam_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group"
  version = "~> 6.8"

  name = "admins"

  users = [
    "user1",
    "user2"
  ]

  enable_self_management_permissions = true
  permissions = {
    AssumeRole = {
      actions   = ["sts:AssumeRole"]
      resources = ["arn:aws:iam::111111111111:role/admin"]
    }
  }

  policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess",
  }
}
