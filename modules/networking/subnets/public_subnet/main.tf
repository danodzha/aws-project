#IGW
resource "aws_internet_gateway" "IGW" {
  vpc_id = "${var.vpc_id}"

  tags = {
    Name = "IGW"
  }
}

variable "vpc_id" {}
output "igw_id" {
    value = "${aws_internet_gateway.IGW.id}"
}

#Subnets
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

#Route table
resource "aws_route_table" "Public_RT" {
    vpc_id = "${var.vpc_id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.IGW.id}"
    }
}

#variable "igw_id" {}
output "route_id" {
    value = "${aws_route_table.Public_RT.id}"
}

#Route asc
resource "aws_route_table_association" "public_asc" {
    count     = "${length(var.subnet_cidr)}"
    subnet_id = "${aws_subnet.subnets.*.id[count.index]}"
    route_table_id = "${aws_route_table.Public_RT.id}"
}

#variable "subnet_id" {}
#variable "route_table_id" {}

resource "aws_security_group" "dev_public_sg" {
  name        = "dev_public_sg"
  description = "Used for access to the public instances"
  vpc_id      = "${var.vpc_id}"

  #SSH

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.access_ip}"]
  }

#HTTP

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.access_ip}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "access_ip" {}

