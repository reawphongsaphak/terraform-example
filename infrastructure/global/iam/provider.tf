provider "aws" {
  region = var.region
  default_tags { tags = { Environment = "global", ManagedBy = "terraform" } }
}
