variable "this_aws_vpc_cidr_block" {
  type = string
}

variable "this_aws_vpc_instance_tenancy" {
  type = string
}

variable "this_aws_vpc_enable_dns_hostnames" {
  type = bool
}

variable "this_aws_vpc_tags" {
  type = string
}


//public subnet variable

variable "this_public_subnet_cidr_block" {
  type = string
}

variable "this_public_subnet_map_public_ip_on_launch" {
  type = bool
}

variable "this_public_subnet_tags" {
  type = string
}


// internet gatway variable

variable "this_aws_internet_gateway_tags" {
  type = string
}


//public route table variable

variable "this_public_route_table_cidr_block" {
  type = string
}

variable "this_public_route_table_tags" {
  type = string
}

//private subnet variable
variable "this_private_subnet_cidr_block" {
  type = string
}

variable "this_private_subnet_tags" {
  type = string
}


//nat gateway variable

variable "this_nat_gateway_allocation_id" {
  type = string
}  

//private route table variable

variable "this_private_route_table_cidr_block" {
  type = string
}

variable "this_private_route_table_tags" {
  type = string
}
