resource "aws_vpc" "this_aws_vpc" {
  cidr_block           = var.this_aws_vpc_cidr_block //"10.10.0.0/16"
  instance_tenancy     =  var.this_aws_vpc_instance_tenancy //"default"
  enable_dns_hostnames = var.this_aws_vpc_enable_dns_hostnames //"true"

  tags = {
    Name = var.this_aws_vpc_tags //"terraform_vpc"
  }
}


resource "aws_subnet" "this_public_subnet" {
  vpc_id                  = aws_vpc.this_aws_vpc.id
  cidr_block              = var.this_public_subnet_cidr_block //"10.10.1.0/24"
  map_public_ip_on_launch = var.this_public_subnet_map_public_ip_on_launch //"true"

  tags = {
    Name = var.this_public_subnet_tags //"public"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this_aws_vpc.id

  tags = {
    Name = var.this_aws_internet_gateway_tags //"terrafom-igw"
  }
}


resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.this_aws_vpc.id

  route {
    cidr_block = var.this_public_route_table_cidr_block //"0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.this_public_route_table_tags //"public_route_table"
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.this_public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_subnet" "this_private_subnet" {
  vpc_id     = aws_vpc.this_aws_vpc.id
  cidr_block = var.this_private_subnet_cidr_block //"10.10.2.0/24"

  tags = {     
    Name = var.this_private_subnet_tags //"private"
  }
}


resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = var.this_nat_gateway_allocation_id  //"eipalloc-0d5bcd82c12991d41" 
  subnet_id     = aws_subnet.this_public_subnet.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.this_aws_vpc.id

  route {
    cidr_block     = var.this_private_route_table_cidr_block  //"0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = var.this_private_route_table_tags //"private_route_table"
  }
}

resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.this_private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

/*resource "aws_network_acl" "this_nacl" {
  vpc_id     = aws_vpc.this_aws_vpc.id
  subnet_ids = [aws_subnet.this_public_subnet.id]

  egress {
    rule_no    = 100
    action     = "allow"
    protocol   = -1
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    rule_no    = 100
    action     = "allow"
    protocol   = -1
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0

  }
}*/

