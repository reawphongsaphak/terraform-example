variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "user" {
  type = list(string)
  default = [ "user1", "user2" ]
}