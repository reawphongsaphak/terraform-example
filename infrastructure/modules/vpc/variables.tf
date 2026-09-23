variable "name" {
  description = "resource Name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "zone_names" {
  description = "one public + one private"
  type        = list(string)
  default     = ["zone-1", "zone-2"]
}
