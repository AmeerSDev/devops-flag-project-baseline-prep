# North_Virginia VPC
resource "aws_vpc" "North_Virginia-VPC" {
  provider = aws.North_Virginia
  cidr_block = var.vpc-cidr

  tags = {
    Name = "${var.name-prefix}-VPC"
  }
}

# North_Virginia Public Subnet 1
resource "aws_subnet" "North_Virginia-Public-Subnet-1" {
  provider = aws.North_Virginia
  vpc_id     = aws_vpc.North_Virginia-VPC.id
  cidr_block = var.vpc-public-subnet-1
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.name-prefix}-Public-Subnet1"
  }
}

# North_Virginia Public Subnet 2
resource "aws_subnet" "North_Virginia-Public-Subnet-2" {
  provider = aws.North_Virginia
  vpc_id     = aws_vpc.North_Virginia-VPC.id
  cidr_block = var.vpc-public-subnet-2
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"

  tags = {
    Name = "${var.name-prefix}-Public-Subnet2"
  }
}

# North_Virginia Private Subnet 1
resource "aws_subnet" "North_Virginia-Private-Subnet-1" {
  provider = aws.North_Virginia
  vpc_id     = aws_vpc.North_Virginia-VPC.id
  cidr_block = var.vpc-private-subnet-1
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.name-prefix}-Private-Subnet1"
  }
}

# North_Virginia Private Subnet 2
resource "aws_subnet" "North_Virginia-Private-Subnet-2" {
  provider = aws.North_Virginia
  vpc_id     = aws_vpc.North_Virginia-VPC.id
  cidr_block = var.vpc-private-subnet-2
  availability_zone = "us-east-1b"

  tags = {
    Name = "${var.name-prefix}-Private-Subnet2"
  }
}

# North_Virginia IGW
resource "aws_internet_gateway" "North_Virginia-IGW" {
  provider = aws.North_Virginia
  vpc_id = aws_vpc.North_Virginia-VPC.id

  tags = {
    Name = "${var.name-prefix}-IGW"
  }
}

# North_Virginia Public Route Table
resource "aws_route_table" "North_Virginia-Public-RT" {
  provider = aws.North_Virginia
  vpc_id = aws_vpc.North_Virginia-VPC.id

  tags = {
    Name = "${var.name-prefix}-Public-RT"
  }
}

# North_Virginia Public Route
resource "aws_route" "North_Virginia-Public-Route" {
  provider = aws.North_Virginia
  route_table_id            = aws_route_table.North_Virginia-Public-RT.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.North_Virginia-IGW.id
}

# North_Virginia Route Table Association for Public Subnet 1
resource "aws_route_table_association" "North_Virginia-RTA-Public-Subnet-1" {
  provider = aws.North_Virginia
  subnet_id      = aws_subnet.North_Virginia-Public-Subnet-1.id
  route_table_id = aws_route_table.North_Virginia-Public-RT.id
} 

# North_Virginia Route Table Association for Public Subnet 2
resource "aws_route_table_association" "North_Virginia-RTA-Public-Subnet-2" {
  provider = aws.North_Virginia
  subnet_id      = aws_subnet.North_Virginia-Public-Subnet-2.id
  route_table_id = aws_route_table.North_Virginia-Public-RT.id
} 

# North_Virginia EIP
resource "aws_eip" "North_Virginia-EIP" {
  provider = aws.North_Virginia
  domain = "vpc"
}

# North_Virginia NAT Gateway
resource "aws_nat_gateway" "North_Virginia-NAT" {
  provider = aws.North_Virginia
  allocation_id = aws_eip.North_Virginia-EIP.id
  subnet_id     = aws_subnet.North_Virginia-Public-Subnet-1.id

  tags = {
    Name = "${var.name-prefix}-NAT"
  }
}

# North_Virginia Private Route Table
resource "aws_route_table" "North_Virginia-Private-RT" {
  provider = aws.North_Virginia
  vpc_id = aws_vpc.North_Virginia-VPC.id
  route {
    cidr_block     = "0.0.0.0/0"
    # gateway_id = aws_nat_gateway.North_Virginia-NAT.id
    nat_gateway_id = aws_nat_gateway.North_Virginia-NAT.id
  }
  tags = {
    Name = "${var.name-prefix}-Private-RT"
  }
}

# North_Virginia Route Table Association for Private Subnet 1
resource "aws_route_table_association" "North_Virginia-RTA-Private-Subnet-1" {
  provider = aws.North_Virginia
  subnet_id      = aws_subnet.North_Virginia-Private-Subnet-1.id
  route_table_id = aws_route_table.North_Virginia-Private-RT.id
}

# North_Virginia Route Table Association for Private Subnet 2
resource "aws_route_table_association" "North_Virginia-RTA-Private-Subnet-2" {
  provider = aws.North_Virginia
  subnet_id      = aws_subnet.North_Virginia-Private-Subnet-2.id
  route_table_id = aws_route_table.North_Virginia-Private-RT.id
}
