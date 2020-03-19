# data "aws_vpc" "all" {}
# data "aws_subnet_ids" "all" {
#   vpc_id = data.aws_vpc.all.id
# }
resource "aws_instance" "instance" {
  count         = "${var.instance_count}"
  instance_type = "${var.instance_type}"
  ami           = "${var.ami_id}"

  tags = {
    Name = "Dev-test-${count.index + 1}"
  }

  key_name               = "${var.key-name}"
  vpc_security_group_ids = ["${var.security_group}"]
  #    subnet_id = "${element(var.subnet, count.index)}"
  subnet_id = "${var.subnet}"
}

variable "key-name" {}
variable "instance_count" {}
variable "instance_type" {}
variable "security_group" {}
variable "subnet" {}
variable "ami_id" {}