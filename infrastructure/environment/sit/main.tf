module "vpc" {
  source = "../../modules/vpc"

  name       = "sit"
  vpc_cidr   = var.vpc_cidr
  zone_names = var.names
}

# Resources used to live directly in this root; keep them instead of recreating.
# moved {
#   from = aws_vpc.main
#   to   = module.vpc.aws_vpc.main
# }

# moved {
#   from = aws_subnet.public
#   to   = module.vpc.aws_subnet.public
# }

# moved {
#   from = aws_subnet.private
#   to   = module.vpc.aws_subnet.private
# }

# moved {
#   from = aws_internet_gateway.main
#   to   = module.vpc.aws_internet_gateway.main
# }

# moved {
#   from = aws_route_table.public
#   to   = module.vpc.aws_route_table.public
# }

# moved {
#   from = aws_route_table_association.public
#   to   = module.vpc.aws_route_table_association.public
# }
