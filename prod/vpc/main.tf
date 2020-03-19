##################
#----PROVIDER----#
##################

provider "aws" {
  region = "us-east-1"
}



module "vpc" {
  source   = "../modules/vpc/"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
}

#data "aws_vpc" "available" {}
#data "aws_availability_zones" "available" {}
#module "subnet" {
#  source      = "./modules/networking/"
#  subnet_cidr = var.subnet_cidr
#  subnet_name = var.subnet_name
#  vpc_id      = "${data.aws_vpc.available.id}"
#  az-name     = "${data.aws_availability_zones.available.names}"
#}

##############
#----VARS----#
##############