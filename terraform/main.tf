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
  description = "This is the default cidr block for the vpc. Use base_cidr_block.id to use it."
  default     = "10.0.0.0/16"
}

resource "aws_vpc" "main" {
  cidr_block        = var.base_cidr_block
  instance_tenancy  = "default"
}

resource "aws_subnet" "publicsub" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "privatesub" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2a"
}