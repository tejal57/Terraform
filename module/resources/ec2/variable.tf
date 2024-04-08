variable "this_aws_public_instance_instance_type" {
  type    = string
}

variable "this_aws_public_instance_key_name" {
  type    = string
}

variable "this_aws_public_instance_availability_zone" {
  type    = string
}

/*variable "this_aws_public_instance_user_data_base64" {
  type    = bool
}*/

variable "this_aws_public_instance_tags" {
  type    = string
}

variable "this_aws_public_instance_ami" {
  type    = string
}

variable "this_aws_public_instance_associate_public_ip_address" {
  type = bool
}

variable "this_aws_public_instance_volume_size" {
  type = number
}

variable "this_aws_public_instance_subnet_id" {
  type = string
}

variable "this_sg_vpc_id" {
  type = string
}