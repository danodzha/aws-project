resource "aws_subnet" "subnets" {
  count     = "${length(var.subnet_cidr)}"
  vpc_id    = "${var.vpc_id}"
  cidr_block = "${var.subnet_cidr[count.index]}"
  availability_zone = "${var.az-name[count.index]}"
  map_public_ip_on_launch = "${var.public_ip_assignment}"

  tags = {
    Name = "${var.subnet_name}_${count.index + 1}"
  }
}

variable "vpc_id" {}
variable "subnet_cidr" {
  type = "list"
}
variable "subnet_name" {}
variable "az-name" {}
variable "public_ip_assignment" {
  default = false
}

output "pb_sbn_id" {
    value = "${aws_subnet.subnets.*.id}"
}

resource "aws_route_table_association" "public_asc" {
    count     = "${length(var.subnet_cidr)}"
    subnet_id = "${aws_subnet.subnets.*.id[count.index]}"
    route_table_id = "${var.def_route}"
}

variable "def_route" {}