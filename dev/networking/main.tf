data "aws_availability_zones" "available" {}
data "aws_vpc" "available" {}

module "subnet" {
  source      = "../../modules/networking/subnets/public_subnet/"
  subnet_cidr = "${var.pub_subnet_cidr}"
  subnet_name = "${var.pub_subnet_name}"
  vpc_id      = "${var.vpc_id}"
  az-name     = "${data.aws_availability_zones.available.names}"
  public_ip_assignment = true
  access_ip   = "${var.access_ip}"
}
module "subnet2" {
  source      = "../../modules/networking/subnets/private_subnet/"
  subnet_cidr = "${var.priv_subnet_cidr}"
  subnet_name = "${var.priv_subnet_name}"
  vpc_id      = "${var.vpc_id}"
  az-name     = "${data.aws_availability_zones.available.names}"
  def_route   = "${data.aws_vpc.available.main_route_table_id}"
}
module "subnet3" {
  source      = "../../modules/networking/subnets/private_subnet/"
  subnet_cidr = "${var.db_subnet_cidr}"
  subnet_name = "${var.db_subnet_name}"
  vpc_id      = "${var.vpc_id}"
  az-name     = "${data.aws_availability_zones.available.names}"
  def_route   = "${data.aws_vpc.available.main_route_table_id}"
}

variable "pub_subnet_cidr" {}
variable "priv_subnet_cidr" {}
variable "db_subnet_cidr" {}
variable "pub_subnet_name" {}
variable "priv_subnet_name" {}
variable "db_subnet_name" {}
variable "vpc_id" {}
variable "access_ip" {}