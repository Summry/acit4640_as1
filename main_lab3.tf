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
  description = "default cidr block for vpc"
  default     = "10.0.0.0/16"
}

resource "aws_vpc" "main" {
  cidr_block       = var.base_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "main"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-ipg"
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-route"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

# security group for instances COMPLETE ME!
resource "aws_security_group" "main" {
  name        = "main_SG"
  description = "general security group for EC2 instances"
  vpc_id      = aws_vpc.main.id
}

# security group egress rules COMPLETE ME!
resource "aws_vpc_security_group_egress_rule" "main" {
# make this open to everything from everywhere
  security_group_id = aws_security_group.main.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1" // allow access from any protocol
  # to_port is not required since ip_protocol = -1
  # from_port is not required since ip_protocol = -1
}

# security group ingress rules COMPLETE ME!
resource "aws_vpc_security_group_ingress_rule" "aws_vpc_ingress_ssh" {
# ssh and http in from everywhere
  security_group_id = aws_security_group.main.id

  // SSH access from anywhere
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp" // allow access using tcp protocol
}

# security group ingress rules COMPLETE ME!
resource "aws_vpc_security_group_ingress_rule" "aws_vpc_ingress_http" {
# ssh and http in from everywhere
  security_group_id = aws_security_group.main.id

  // HTTP access from anywhere
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp" // allow access using tcp protocol
}

# get the most recent ami for Ubuntu 22.04
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-lunar-23.04-amd64-server-*"]
  }
}

# key pair from local key COMPLETE ME!
resource "aws_key_pair" "local_key" {
  key_name   = "week3_key"
  public_key = file("~/.ssh/week3_key.pub")
}

# ec2 instance COMPLETE ME!
resource "aws_instance" "ubuntu" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.ubuntu.id
  
  tags = {
    Name = "ubuntu-server"
  }

  key_name               = aws_key_pair.local_key.key_name
  vpc_security_group_ids = [aws_security_group.main.id]
  subnet_id              = aws_subnet.main.id

  root_block_device {
    volume_size = 10
  }
}

# output public ip address of the 2 instances
output "instance_public_ips" {
  value = aws_instance.ubuntu.public_ip
}