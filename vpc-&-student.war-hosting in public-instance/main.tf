resource "aws_vpc" "this_aws_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "my_vpc"
  }
}


resource "aws_subnet" "this_public_subnet" {
  vpc_id                  = aws_vpc.this_aws_vpc.id
  cidr_block              = "10.0.0.0/18"
  map_public_ip_on_launch = true

  tags = {
    Name = "public"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this_aws_vpc.id

  tags = {
    Name = "terrafom-igw"
  }
}


resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.this_aws_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.this_public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_subnet" "this_private_subnet" {
  vpc_id     = aws_vpc.this_aws_vpc.id
  cidr_block = "10.0.64.0/19"

  tags = {     
    Name = "private"
  }
}


resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "eipalloc-0ba6040958b793b7c" //, aws_instance.this_aws_public_instance[0].network_interface_ids[0]] # [count of instance]
  subnet_id     = aws_subnet.this_public_subnet.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.this_aws_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "private_route_table"
  }
}

resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.this_private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_network_acl" "this_nacl" {
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
}


resource "aws_instance" "this_aws_public_instance" {
  ami                         = "ami-0a0409af1cb831414"
  instance_type               = "t2.small"
  key_name                    = "california-key"
  vpc_security_group_ids      = [aws_security_group.this_sg.id]
  availability_zone           = "us-west-1b"
  subnet_id                   = aws_subnet.this_public_subnet.id
  associate_public_ip_address = true
  root_block_device {
    volume_size = 18
  }
  //user_data_base64 = var.this_aws_instance_user_data_base64

  tags = {
    Name = "tomcat_instance"
  }

      user_data = <<-EOF
            #!/bin/bash
            sudo apt update
            sudo apt install -y wget
            sudo apt install -y default-jdk
            sudo wget https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.99/bin/apache-tomcat-8.5.99.tar.gz
            sudo tar -xzvf apache-tomcat-8.5.99.tar.gz
            sudo git clone https://github.com/tejal57/tomcat.git
            sudo mv ./tomcat/student.war /home/ubuntu/apache-tomcat-8.5.99/webapps
            sudo /home/ubuntu/apache-tomcat-8.5.99/bin/catalina.sh stop
            sudo /home/ubuntu/apache-tomcat-8.5.99/bin/catalina.sh start
           EOF
}

resource "aws_instance" "this_aws_private_instance" {
  ami                    = "ami-0a0409af1cb831414"
  instance_type          = "t2.small"
  key_name               = "california-key"
  vpc_security_group_ids = [aws_security_group.this_sg.id]
  availability_zone      = "us-west-1b"
  subnet_id              = aws_subnet.this_private_subnet.id

  root_block_device {
    volume_size = 18
  }

  tags = {
    Name = "database_instance"
  }
}