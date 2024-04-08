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

variable "this_aws_instance_node_tags" {
  type    = string
  default = "jenkins-node"
}

variable "this_aws_instance_volume_size" {
  type    = number
  default = 18
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




   