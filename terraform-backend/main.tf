resource "aws_instance" "this_aws_instance" {
  ami                    = data.aws_ami.this_ami.id
  instance_type          = var.this_aws_instance_instance_type
  key_name               = var.this_aws_instance_key_name
  availability_zone      = var.this_aws_instance_availability_zone
  root_block_device {
    volume_size = var.this_aws_instance_volume_size
  }
  //user_data_base64 = var.this_aws_instance_user_data_base64

  tags = {
    Name = var.this_aws_instance_tags
  }
}

//data block

data "aws_ami" "this_ami" {
  name_regex = "my_iam"
  filter {
    name   = "name"
    values = ["my_iam"]
  }
}

//variable block

variable "this_aws_instance_instance_type" {
  type    = string
  default = "t2.small"
}

variable "this_aws_instance_key_name" {
  type    = string
  default = "california-key"
}

variable "this_aws_instance_availability_zone" {
  type    = string
  default = "us-west-1a"
}

variable "this_aws_instance_user_data_base64" {
  type    = bool
  default = true
}

variable "this_aws_instance_tags" {
  type    = string
  default = "jenkins-master"
}

variable "this_aws_instance_volume_size" {
  type    = number
  default = 18
}


resource "aws_s3_bucket" "s3_bucket" {
  bucket = "tejal-terraform-buket"
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock2"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}