variable "vpc_cidr" {}
variable "vpc_name" {}
#variable "subnet_cidr" {
#  type = "list"
#}
#variable "subnet_name" {}

variable "vpc_id" {
  type = "map"
  default = {
    Name = "DEMO"
  }
}