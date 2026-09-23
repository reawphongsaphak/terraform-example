provider "aws" {
  region = var.region
  default_tags { tags = { Environment = "sit", ManagedBy = "terraform" } }
}