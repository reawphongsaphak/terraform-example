module "vpc" {
  source = "../../modules/vpc"

  name       = "dev"
  vpc_cidr   = var.vpc_cidr
  zone_names = var.names
}
