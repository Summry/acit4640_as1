terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

variable "base_cidr_block" {
  description = "This is the default cidr block for the vpc. Use var.base_cidr_block to use it."
  default     = "10.0.0.0/16"
}

resource "aws_vpc" "main" {
  cidr_block        = var.base_cidr_block
  instance_tenancy  = "default"
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_subnet" "publicsub" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "privatesub" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2a"
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "default_route" {
  route_table_id = aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "main" {
  subnet_id = aws_subnet.publicsub.id
  route_table_id = aws_route_table.main.id
}

resource "aws_security_group" "publicsg" {
  name = "publicsg"
  description = "security group for public subnet"
  vpc_id = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "aws_vpc_ingress_ssh" {
  # This inbound traffic rule allows SSH access from anywhere - attach it to the public subnet security group.
  security_group_id = aws_security_group.publicsg.id

  cidr_ipv4 = "0.0.0.0/0"
  from_port = 22
  to_port = 22
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "aws_vpc_ingress_http" {
  # This inbound traffic rule allows HTTP access from anywhere - attach it to the public subnet security group.
  security_group_id = aws_security_group.publicsg.id

  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
}

resource "aws_security_group" "privatesg" {
  name = "privatesg"
  vpc_id = aws_vpc.main.id
  description = "security group for private subnet"
}

resource "aws_vpc_security_group_ingress_rule" "aws_vpc_ingress_ssh" {
  security_group_id = aws_security_group.privatesg.id

  from_port = 22
  to_port = 22
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "aws_vpc_ingress_http" {
  security_group_id = aws_security_group.privatesg.id

  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
}