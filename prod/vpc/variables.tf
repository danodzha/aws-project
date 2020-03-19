variable "vpc_cidr" {}
variable "vpc_name" {}
#variable "subnet_cidr" {
#  type = "list"
#}
#variable "subnet_name" {}

variable "subnet_cidr" {
  type    = "list"
  default = ["10.0.1.0/24"]
}
variable "subnet_name" {
  default = "PB"
}

variable "vpc_id" {
  type = "map"
  default = {
    Name = "DEMO"
  }
}