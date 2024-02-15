# Nazira Fakhrurradi

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

resource "aws_vpc" "main_vpc" {
  cidr_block        = var.base_cidr_block
  instance_tenancy  = "default"
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2a"
}

resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route" "default_route" {
  route_table_id = aws_route_table.main_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "rt_associator" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.main_route_table.id
}

resource "aws_security_group" "public_sg" {
  name = "public_sg"
  description = "security group for public subnet"
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_vpc_security_group_egress_rule" "pub_out_any" {
  security_group_id = aws_security_group.public_sg.id

  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "pub_in_ssh" {
  # This inbound traffic rule allows SSH access from anywhere - attach it to the public subnet security group.
  security_group_id = aws_security_group.public_sg.id

  cidr_ipv4 = "0.0.0.0/0"
  from_port = 22
  to_port = 22
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "pub_in_http" {
  # This inbound traffic rule allows HTTP access from anywhere - attach it to the public subnet security group.
  security_group_id = aws_security_group.public_sg.id

  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
}

resource "aws_security_group" "private_sg" {
  name = "private_sg"
  vpc_id = aws_vpc.main_vpc.id
  description = "security group for private subnet"
}

resource "aws_vpc_security_group_ingress_rule" "prv_in_ssh" {
  security_group_id = aws_security_group.private_sg.id

  from_port = 22
  to_port = 22
  ip_protocol = "tcp"
  cidr_ipv4 = var.base_cidr_block
}

resource "aws_vpc_security_group_ingress_rule" "prv_in_http" {
  security_group_id = aws_security_group.private_sg.id

  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
  cidr_ipv4 = var.base_cidr_block
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = [ "099720109477" ]

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-lunar-23.04-amd64-server-*"]
  }
}

resource "aws_key_pair" "local_key" {
  key_name = "4640_key"
  public_key = file("~/.ssh/4640_key.pub")
}

resource "aws_instance" "public_instance" {
  instance_type = "t2.micro"
  ami = data.aws_ami.ubuntu.id
  
  tags = {
    Name = "assignment1-public-ubuntu"
  }

  key_name = aws_key_pair.local_key.key_name
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  subnet_id = aws_subnet.public_subnet.id

  root_block_device {
    volume_size = 10
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install nginx -y
  EOF
}

resource "aws_instance" "private_instance" {
  instance_type = "t2.micro"
  ami = data.aws_ami.ubuntu.id

  tags = {
    Name = "assignment1-private-ubuntu"
  }

  key_name = aws_key_pair.local_key.key_name
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  subnet_id = aws_subnet.private_subnet.id

  root_block_device {
    volume_size = 10
  }
}

output "public_instance_ip" {
  value = aws_instance.public_instance.public_ip
}