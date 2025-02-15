#VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "IAC-jenkins-VPC"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "IAC-jenkins-IGW2"
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet1_cidr_block
  map_public_ip_on_launch = true
  tags = {
    Name = "IAC-jenkins-Public-Subnet1"
  }
}

# Public Subnet2
resource "aws_subnet" "public2_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet2_cidr_block
  tags = {
    Name = "IAC-jenkins-public-Subnet2"
  }
}

# Route Table for Public Subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "IAC-jenkins-Public-RT1"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

# Route Table for Private Subnet


# (NAT Gateway and Elastic IP resources here...)

# Associate Public Route Table with Public Subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# EC2 Instance in the Public Subnet
resource "aws_instance" "web_public" {
  ami                         = var.ami
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  user_data                   = file("userdata.sh")
  vpc_security_group_ids      = [aws_security_group.allow_web.id]
  key_name                    = "oluchi"
  tags = {
    Name = "IAC-jenkins-Instance1"
  }
}

# EC2 Instance in the Public Subnet2
resource "aws_instance" "web_public2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public2_subnet.id
  associate_public_ip_address = true
  user_data                   = file("userdata2.sh")
  vpc_security_group_ids      = [aws_security_group.allow_web.id]
  key_name                    = "oluchi"
  tags = {
    Name = "IAC=jenkins2-public-Instance2"
  }
}

