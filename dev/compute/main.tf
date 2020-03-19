module "ec2" {
  source         = "../../modules/compute"
  key-name       = "${var.key-name}"
  instance_count = "${var.instance_count}"
  instance_type  = "${var.instance_type}"
  security_group = "${var.security_group}"
  subnet         = "${var.subnet}"
  ami_id         = "${var.ami_id}"
}

variable "key-name" {}
variable "instance_count" {}
variable "instance_type" {}
variable "security_group" {}
variable "subnet" {}
variable "ami_id" {}