# Create a VPC
resource "aws_vpc" "Kenny-VPC" {
  cidr_block = "100.0.0.0/16"
 instance_tenancy = "default"
  tags = {
  Name = "Kenny-2-VPC"
}
}
#Public Subnets for VPC
resource "aws_subnet" "Pub-Sub-1" {
  vpc_id     = aws_vpc.Kenny-VPC.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "pub-Sub-1"
  }
}

#Public Subnets for VPC
resource "aws_subnet" "Pub-Sub-2" {
  vpc_id     = aws_vpc.Kenny-VPC.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "pub-Sub-2"
  }
}

#Private Subnets for VPC
resource "aws_subnet" "Pri-Sub-1" {
  vpc_id     = aws_vpc.Kenny-VPC.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "pri-Sub-1"
  }
}

#Private Subnets for VPC
resource "aws_subnet" "Pri-Sub-2" {
  vpc_id     = aws_vpc.Kenny-VPC.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "pri-Sub-2"
  }
}

#VPC Public Route-Table
resource "aws_route_table" "Public-route-table" {
  vpc_id = aws_vpc.Kenny-VPC.id
}

#VPC Private Route-Table
resource "aws_route_table" "Private-route-table" {
  vpc_id = aws_vpc.Kenny-VPC.id
}
#public-route-table association
resource "aws_route_table_association" "Public-route-table-association-1" {
  subnet_id      = aws_subnet.Pub-Sub-1.id
  route_table_id = aws_route_table.Public-route-table.id
}

#public-route-table association
resource "aws_route_table_association" "Public-route-table-association-2" {
  subnet_id      = aws_subnet.Pub-Sub-2.id
  route_table_id = aws_route_table.Public-route-table.id
}

#private-route-table association
resource "aws_route_table_association" "Private-route-table-association-1" {
  subnet_id      = aws_subnet.Pri-Sub-1.id
  route_table_id = aws_route_table.Private-route-table.id
}

#private-route-table association
resource "aws_route_table_association" "rivate-route-table-association-2" {
  subnet_id      = aws_subnet.Pri-Sub-2.id
  route_table_id = aws_route_table.Private-route-table.id
}

resource "aws_internet_gateway" "kennyigw" {
  vpc_id = aws_vpc.Kenny-VPC.id

  tags = {
    Name = "kennyigw"
  }
}
resource "aws_route" "Public-route-table" {
  route_table_id            = aws_route_table.Public-route-table.id
  gateway_id                 = aws_internet_gateway.kennyigw.id
  destination_cidr_block    = "0.0.0.0/0"
}
