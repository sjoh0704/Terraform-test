resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "terra-test-vpc"  
}
}


resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main.id  
  cidr_block = "10.0.0.0/24"

  availability_zone = "us-west-1b"
  tags = {
    Name = "terra-test-public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "us-west-1c"
  tags = {
    Name = "terra-test-private-subnet"
  }

}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "terra-test-IGW"
  }
}

resource "aws_eip" "nat_eip" {
  vpc   = true

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.public_subnet.id

  tags = {
    Name = "terra-test-NAT-GW"
  }
}

resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "public-RT"
  }
}

resource "aws_route_table" "route_table_private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private-RT"
  }
}

resource "aws_route_table_association" "route_table_association_public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route_table_public.id
}

resource "aws_route_table_association" "route_table_association_private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.route_table_private.id
}

resource "aws_route" "public_igw" {
  route_table_id              = aws_route_table.route_table_public.id
  destination_cidr_block      = "0.0.0.0/0"
  gateway_id         = aws_internet_gateway.igw.id
}

resource "aws_route" "private_nat" {
  route_table_id              = aws_route_table.route_table_private.id
  destination_cidr_block      = "0.0.0.0/0"
  nat_gateway_id              = aws_nat_gateway.nat_gateway.id
}

resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.us-west-1.s3"
}

