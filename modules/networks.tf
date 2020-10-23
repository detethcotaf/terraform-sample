resource "aws_vpc" "sample_vpc" {
  assign_generated_ipv6_cidr_block = "false"
  cidr_block                       = var.VPC_CIDR
  enable_classiclink               = "false"
  enable_classiclink_dns_support   = "false"
  enable_dns_hostnames             = "true"
  enable_dns_support               = "true"
  instance_tenancy                 = "default"

  tags = {
    Name  = "sample_vpc_${var.ENV}"
    Env = var.ENV
  }
}

resource "aws_subnet" "sample_subnet_a" {
  assign_ipv6_address_on_creation = "false"
  cidr_block                      = var.SUBNET_A_CIDR
  map_public_ip_on_launch         = "true"
  availability_zone               = "ap-northeast-1a"

  tags = {
    Name = "sample_subnet_${var.ENV}_1a"
    Env = var.ENV
  }

  vpc_id = aws_vpc.sample_vpc.id
}

resource "aws_subnet" "sample_subnet_c" {
  assign_ipv6_address_on_creation = "false"
  cidr_block                      = var.SUBNET_C_CIDR
  map_public_ip_on_launch         = "true"
  availability_zone               = "ap-northeast-1c"

  tags = {
    Name = "sample_subnet_${var.ENV}_1c"
    Env = var.ENV
  }

  vpc_id = aws_vpc.sample_vpc.id
}


resource "aws_internet_gateway" "sample_igw" {
  tags = {
    Name  = "sample_igw_${var.ENV}"
    Env = var.ENV
  }

  vpc_id = aws_vpc.sample_vpc.id
}


resource "aws_route_table" "sample_rt" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sample_igw.id
  }

  tags = {
    Name  = "sample_rt_${var.ENV}"
    Env = var.ENV
  }

  vpc_id = aws_vpc.sample_vpc.id
}

resource "aws_main_route_table_association" "sample_rt_vpc" {
  route_table_id = aws_route_table.sample_rt.id
  vpc_id         = aws_vpc.sample_vpc.id
}

resource "aws_route_table_association" "sample_rt_subet_a" {
  route_table_id = aws_route_table.sample_rt.id
  subnet_id      = aws_subnet.sample_subnet_a.id
}

resource "aws_route_table_association" "sample_rt_subnet_c" {
  route_table_id = aws_route_table.sample_rt.id
  subnet_id      = aws_subnet.sample_subnet_c.id
}