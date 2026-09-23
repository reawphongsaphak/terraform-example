variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "names" {
  type    = list(string)
  default = ["zone-1", "zone-2"]
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}