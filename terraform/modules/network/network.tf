# VPC
resource "aws_vpc" "my_vpc" {
  cidr_block       = "172.20.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = var.project_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "devops_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = var.project_name
  }
}

# Public Subnet
resource "aws_subnet" "devops_public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "172.20.1.0/24"
  availability_zone       = var.availability_zone_names1
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet-DevOps_Challenge"
  }
}

# Public Subnet for the App

resource "aws_subnet" "app_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "172.20.2.0/24"
  availability_zone       = var.availability_zone_names1
  map_public_ip_on_launch = false

  tags = {
    Name = "app_subnet-DevOps_Challenge"
  }
}

# Database PSubnet
resource "aws_subnet" "db_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "172.20.3.0/24"
  availability_zone       = var.availability_zone_names2
  map_public_ip_on_launch = true

  tags = {
    Name = "db_subnet-DevOps_Challenge"
  }
}


# Route Table
resource "aws_route_table" "devops_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops_igw.id
  }

  tags = {
    Name = "public_rt-DevOps_Challenge"
  }
}

# Public Subnet - Route Table Association
resource "aws_route_table_association" "rt_assoc" {
  subnet_id      = aws_subnet.devops_public_subnet.id
  route_table_id = aws_route_table.devops_rt.id
}

# DB Subnet - Route Table Association
resource "aws_route_table_association" "db_rt_assoc" {
  subnet_id      = aws_subnet.db_subnet.id
  route_table_id = aws_route_table.devops_rt.id
}

# Web Access Security Group
resource "aws_security_group" "permit_web_traffic" {
  name        = "permit_web_traffic"
  description = "Permit Inbound HTTP traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "Global HTTP Access"
    from_port   = var.httpport
    to_port     = var.httpport
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "Global HTTPS Acess"
    from_port   = var.httpsport
    to_port     = var.httpsport
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "GLobal SSH Access"
    from_port   = var.sshport
    to_port     = var.sshport
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "GLobal SSH Access2"
    from_port   = var.sshport2
    to_port     = var.sshport2
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = var.internetport
    to_port     = var.internetport
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }

}

# Microservice Security Group
resource "aws_security_group" "app_sg" {
  name        = "app_sg"
  description = "Permit inbound TCP traffic from LB"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description     = "HTTP from LB"
    from_port       = var.httpport
    to_port         = var.httpport
    protocol        = "tcp"
    security_groups = [aws_security_group.permit_web_traffic.id]
  }

  ingress {
    description     = "UI Access from LB"
    from_port       = var.customlb1port
    to_port         = var.customlb1port
    protocol        = "tcp"
    security_groups = [aws_security_group.permit_web_traffic.id]

  }

  ingress {
    description     = "API Access from LB"
    from_port       = var.customlb2port
    to_port         = var.customlb2port
    protocol        = "tcp"
    security_groups = [aws_security_group.permit_web_traffic.id]

  }

  ingress {
    description = "SSH from LB"
    from_port   = var.sshport
    to_port     = var.sshport
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "GLobal SSH Access2"
    from_port   = var.sshport2
    to_port     = var.sshport2
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = var.internetport
    to_port     = var.internetport
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "microservice_access"
  }

}

# DB Security Group
resource "aws_security_group" "rds_sg" {
  name_prefix = "rds-"
  description = "Permit microservice inbout traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description     = "Permit Microservice TCP Traffic"
    from_port       = var.port
    to_port         = var.port
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  egress {
    from_port   = var.internetport
    to_port     = var.internetport
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds_sg"
  }

}

resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.app_subnet.id, aws_subnet.db_subnet.id]

  tags = {
    Name = "My DB Subnet Group"
  }
}
