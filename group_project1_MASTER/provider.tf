provider "aws" {
  version = "~> 2.66"
  region  = "us-east-1"
}

resource "aws_vpc" "project1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "dedicated"

  tags = {
    Name = "project1"
  }
}

#creating Public subnets
resource "aws_subnet" "public1" {
  vpc_id                  = "${aws_vpc.project1.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "public_subnet1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = "${aws_vpc.project1.id}"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "public_subnet2"
  }
}

resource "aws_subnet" "public3" {
  vpc_id                  = "${aws_vpc.project1.id}"
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"

  tags = {
    Name = "public_subnet3"
  }
}

#creating private subnets
resource "aws_subnet" "private1" {
  vpc_id                  = "${aws_vpc.project1.id}"
  cidr_block              = "10.0.11.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "private_subnet1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id                  = "${aws_vpc.project1.id}"
  cidr_block              = "10.0.22.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "private_subnet2"
  }
}

resource "aws_subnet" "private3" {
  vpc_id                  = "${aws_vpc.project1.id}"
  cidr_block              = "10.0.33.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"

  tags = {
    Name = "private_subnet3"
  }
}
