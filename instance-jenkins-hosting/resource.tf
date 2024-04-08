resource "aws_instance" "this_aws_instance" {
  ami                    = data.aws_ami.this_ami.id
  instance_type          = var.this_aws_instance_instance_type
  key_name               = var.this_aws_instance_key_name
  vpc_security_group_ids = ["sg-0e79995b88f3e8cc9", aws_security_group.this_sg.id]
  availability_zone      = var.this_aws_instance_availability_zone
  root_block_device {
    volume_size = var.this_aws_instance_volume_size
  }
  //user_data_base64 = var.this_aws_instance_user_data_base64

  tags = {
    Name = var.this_aws_instance_tags
  }

  user_data = <<-EOF
  #! /bin/bash
  sudo apt-get update
  sudo apt-get install -y default-jdk
  sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
  echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
  sudo apt-get update
  sudo apt-get install -y jenkins 
  EOF

}


resource "aws_instance" "this_aws_node_instance" {
  ami                    = data.aws_ami.this_ami.id
  instance_type          = var.this_aws_instance_instance_type
  key_name               = var.this_aws_instance_key_name
  vpc_security_group_ids = ["sg-0e79995b88f3e8cc9", aws_security_group.this_sg.id]
  availability_zone      = var.this_aws_instance_availability_zone
  root_block_device {
    volume_size = var.this_aws_instance_volume_size
  }
  //user_data_base64 = var.this_aws_instance_user_data_base64

  tags = {
    Name = var.this_aws_instance_node_tags
  }

  user_data = <<-EOF
  #! /bin/bash
  sudo apt-get update
  sudo apt-get install -y default-jdk
  sudo apt-get update
  sudo apt-get install -y jenkins
  EOF

}


resource "aws_security_group" "this_sg" {
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_db_instance" "this_aws_db" {
  instance_class = var.this_aws_db_instance_instance_class
  //db_subnet_group_name = "rds-ec2-db-subnet-group-1"
  vpc_security_group_ids = [aws_security_group.this_sg.id]
  engine                 = var.this_aws_db_instance_engine
  username               = var.this_aws_db_instance_username
  password               = var.this_aws_db_instance_password
  allocated_storage      = var.this_aws_db_instance_allocated_storage
  storage_type           = var.this_aws_db_instance_storage_type
}


