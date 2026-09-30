module "vpc" {
  source = "../../modules/vpc"

  name       = "sit"
  vpc_cidr   = var.vpc_cidr
  zone_names = var.names
}