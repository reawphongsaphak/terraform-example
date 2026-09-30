module "iam_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "~> 6.8"

  for_each = toset(var.user)

  name = each.key

  create_login_profile    = true
  password_length         = 24
  password_reset_required = true
  create_access_key       = false

  tags = {
    Terraform   = "true"
    Environment = "sit"
  }
}

output "user_initial_passwords" {
  value     = { for k, u in module.iam_user : k => u.login_profile_password }
  sensitive = true
}
