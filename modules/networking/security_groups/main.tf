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

  variable "vpc_id" {}
  variable "access_ip" {}