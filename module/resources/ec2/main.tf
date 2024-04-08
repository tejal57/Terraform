resource "aws_instance" "this_aws_public_instance" {
  ami                         = var.this_aws_public_instance_ami //"ami-0a0409af1cb831414"
  instance_type               = var.this_aws_public_instance_instance_type  //"t2.small"
  key_name                    = var.this_aws_public_instance_key_name  //"california-key"
  vpc_security_group_ids      = [aws_security_group.this_sg.id]
  availability_zone           = var.this_aws_public_instance_availability_zone  //"us-west-1a"
  subnet_id                   = var.this_aws_public_instance_subnet_id
  associate_public_ip_address = var.this_aws_public_instance_associate_public_ip_address //true
  root_block_device {
    volume_size = var.this_aws_public_instance_volume_size //18
  }
  //user_data_base64 = var.this_aws_instance_user_data_base64

  tags = {
    Name = var.this_aws_public_instance_tags  //"jenkins_instance"
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

resource "aws_security_group" "this_sg" {
  vpc_id = var.this_sg_vpc_id
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


/*
module "vpc" {
    source = "/mnt/c/Users/HP/Desktop/b24module/module/dev"
}    
*/