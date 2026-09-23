variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "names" {
  type    = list(string)
  default = ["zone-1", "zone-2"]
}

# Different range from sit (10.0.0.0/16) so the VPCs can be peered later
variable "vpc_cidr" {
  type    = string
  default = "10.1.0.0/16"
}
