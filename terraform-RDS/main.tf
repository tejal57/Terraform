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



variable "this_aws_db_instance_instance_class" {
  type    = string
  default = "db.t2.micro"
}

variable "this_aws_db_instance_engine" {
  type    = string
  default = "mysql"
}

variable "this_aws_db_instance_username" {
  type    = string
  default = "admin"
}

variable "this_aws_db_instance_password" {
  type    = number
  default = 123456789
}

variable "this_aws_db_instance_allocated_storage" {
  type    = number
  default = 10
}

variable "this_aws_db_instance_storage_type" {
  type    = string
  default = "gp2"
}


