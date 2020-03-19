provider "aws" {
    region = "us-east-1"
}

resource "aws_key_pair" "auth_key" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

variable "key_name" {
    default = "my-test-key"
}
variable "public_key_path" {
    default = "/home/terraform/.ssh/id_rsa.pub"
}