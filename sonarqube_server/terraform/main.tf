# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "sonarqube-vpc"
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "sonarqube-public-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "sonarqube-igw"
  }
}

# Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "sonarqube-public-rt"
  }
}

# Route Table Association
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Security Group for SonarQube
resource "aws_security_group" "sonarqube_sg" {
  name        = "sonarqube-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_ingress_cidr]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.http_ingress_cidr]
  }

  ingress {
    description = "SonarQube Web UI"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = [var.http_ingress_cidr]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sonarqube-security-group"
  }
}

# SSH Key Pair
resource "aws_key_pair" "sonarqube" {
  key_name   = var.key_pair_name
  public_key = file(var.public_key_path)
}

# EC2 Instance
resource "aws_instance" "sonarqube" {
  ami                         = data.aws_ami.Amazon_AMI.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  key_name                    = aws_key_pair.sonarqube.key_name
  vpc_security_group_ids      = [aws_security_group.sonarqube_sg.id]
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/../bootfiles/userdata.tpl", {})


  tags = {
    Name = "sonarqube-server"
  }
}