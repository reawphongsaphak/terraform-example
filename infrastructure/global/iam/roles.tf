module "iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "~> 6.8"

  name = "example"

  trust_policy_permissions = {
    TrustRoleAndServiceToAssume = {
      actions = [
        "sts:AssumeRole",
        "sts:TagSession",
      ]
      principals = [{
        type = "AWS"
        identifiers = [
          "arn:aws:iam::835367859851:user/anton",
        ]
      }]
      condition = [{
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = ["some-secret-id"]
      }]
    }
  }

  policies = {
    ReadOnlyAccess = "arn:aws:iam::aws:policy/ReadOnlyAccess"
    custom         = module.iam_policy.arn
  }

  tags = {
    Terraform   = "true"
    Environment = "sit"
  }
}
