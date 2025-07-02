variable "vpc_cidr" {}
variable "vpc_name" {}
variable "public_subnet_config" {}
variable "private_subnet_config" {}
variable "availability_zone" {}

# Setup VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

# Setup public subnet
resource "aws_subnet" "public" {
  for_each = var.public_subnet_config
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "public-subnet-az-${each.value.az}"
  }
}

# Setup private subnet
resource "aws_subnet" "private" {
  for_each = var.private_subnet_config

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "private-subnet-az-${each.value.az}"
  }
}

# Setup Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "terra_jenkins_project-igw"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "terra_jenkins_project-public-rt"
  }
}

# Public Route Table and public Subnet Association
resource "aws_route_table_association" "public_assoc" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "terra_jenkins_project-private-rt"
  }
}

# Private Route Table and private Subnet Association
resource "aws_route_table_association" "private_assoc" {
  for_each = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}


