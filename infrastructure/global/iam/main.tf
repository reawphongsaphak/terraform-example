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
