resource "aws_vpc" "dawid-terra" {
  cidr_block           = "10.0.0.0/26"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
  	Name       = var.name
    bootcamp   = var.bootcamp
    created_by = var.created_by
  }
}

resource "aws_subnet" "dawid-terra-1" {
  vpc_id            = aws_vpc.dawid-terra.id
  cidr_block        = "10.0.0.0/28"
  availability_zone = var.av_zone_1
  tags = {
  	Name       = "dawid-terra-1"
    bootcamp   = var.bootcamp
    created_by = var.created_by
  }
}

resource "aws_internet_gateway" "dawid-terra" {
  vpc_id = aws_vpc.dawid-terra.id
  tags = {
  	Name       = var.name
    bootcamp   = var.bootcamp
    created_by = var.created_by
  }
}

resource "aws_route_table" "dawid-terra" {
  vpc_id = aws_vpc.dawid-terra.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dawid-terra.id
  }
  tags = {
  	Name       = var.name
    bootcamp   = var.bootcamp
    created_by = var.created_by
  }
}

resource "aws_route_table_association" "dawid-terra-1" {
  subnet_id      = aws_subnet.dawid-terra-1.id
  route_table_id = aws_route_table.dawid-terra.id
}

resource "aws_subnet" "dawid-terra-2" {
  count             = (var.num == true ? 1 : 0)
  vpc_id            = aws_vpc.dawid-terra.id
  cidr_block        = "10.0.0.16/28"
  availability_zone = var.av_zone_2
  tags = {
  	Name       = "dawid-terra-2"
    bootcamp   = var.bootcamp
    created_by = var.created_by
  }
}

resource "aws_route_table_association" "dawid-terra-2" {
  count          = (var.num == true ? 1 : 0)
  subnet_id      = aws_subnet.dawid-terra-2[count.index].id
  route_table_id = aws_route_table.dawid-terra.id
}
