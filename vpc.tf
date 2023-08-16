# Networking Resources

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-1b"
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "eu-west-1b"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_eip" "natgw_eip" {
  vpc = true
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.natgw_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id
}

# Setting up route tables for traffic

resource "aws_route_table" "public_routetable" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public-RouteTable"
  }
}

resource "aws_route_table" "private_routetable" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "NatGW-Route"
  }
}

# Associating routetables with subnets 

resource "aws_route_table_association" "public_route_1" {
  route_table_id = aws_route_table.public_routetable.id
  subnet_id      = aws_subnet.public_subnet_1.id
}

resource "aws_route_table_association" "private_route_1" {
  route_table_id = aws_route_table.private_routetable.id
  subnet_id      = aws_subnet.private_subnet_1.id
}


resource "aws_route_table_association" "public_route_2" {
  route_table_id = aws_route_table.public_routetable.id
  subnet_id      = aws_subnet.public_subnet_2.id
}

resource "aws_route_table_association" "private_route_2" {
  route_table_id = aws_route_table.private_routetable.id
  subnet_id      = aws_subnet.private_subnet_2.id
}