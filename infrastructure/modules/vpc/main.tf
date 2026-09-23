data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  # With vpc_cidr = 10.0.0.0/16:
  # public-zone-1  -> 1st AZ, 10.0.0.0/24
  # public-zone-2  -> 2nd AZ, 10.0.1.0/24
  # private-zone-1 -> 1st AZ, 10.0.128.0/24
  # private-zone-2 -> 2nd AZ, 10.0.129.0/24
  zones = {
    for i, name in var.zone_names : name => {
      az           = data.aws_availability_zones.available.names[i]
      public_cidr  = cidrsubnet(var.vpc_cidr, 8, i)
      private_cidr = cidrsubnet(var.vpc_cidr, 8, i + 128)
    }
  }
}

resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags             = { Name = "${var.name}-vpc" }
}

resource "aws_subnet" "public" {
  for_each                = local.zones
  vpc_id                  = aws_vpc.main.id
  availability_zone       = each.value.az
  cidr_block              = each.value.public_cidr
  map_public_ip_on_launch = true
  tags                    = { Name = "${var.name}-public-${each.key}" }
}

# No route table association: private subnets use the VPC main route table (local only)
resource "aws_subnet" "private" {
  for_each          = local.zones
  vpc_id            = aws_vpc.main.id
  availability_zone = each.value.az
  cidr_block        = each.value.private_cidr
  tags              = { Name = "${var.name}-private-${each.key}" }
}

# Public subnets need a route to the internet
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "${var.name}-igw" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = { Name = "${var.name}-public" }
}

resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}
