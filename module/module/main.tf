module "vpc" {
    source = "/mnt/c/Users/HP/Desktop/b24module/resources/vpc"
    this_aws_vpc_cidr_block = "10.10.0.0/16"
    this_aws_vpc_instance_tenancy = "default"
    this_aws_vpc_enable_dns_hostnames = "true"
    this_aws_vpc_tags = "terraform_vpc"
    this_public_subnet_cidr_block = "10.10.1.0/24"
    this_public_subnet_map_public_ip_on_launch = "true"
    this_public_subnet_tags = "public"
    this_aws_internet_gateway_tags = "terrafom-igw"
    this_public_route_table_cidr_block = "0.0.0.0/0"
    this_public_route_table_tags = "public_route_table"
    this_private_subnet_cidr_block = "10.10.2.0/24"
    this_private_subnet_tags = "private"
    this_nat_gateway_allocation_id = "eipalloc-0b8d69238b7d3ca10" 
    this_private_route_table_cidr_block = "0.0.0.0/0"
    this_private_route_table_tags = "private_route_table" 
}

module "ec2" {
  source = "/mnt/c/Users/HP/Desktop/b24module/resources/ec2"
  this_aws_public_instance_instance_type = "t2.small"
  this_aws_public_instance_key_name = "california-key"
  this_aws_public_instance_availability_zone = "us-west-1a"
  this_aws_public_instance_tags = "jenkins_instance"
  this_aws_public_instance_ami = "ami-0a0409af1cb831414"
  this_aws_public_instance_associate_public_ip_address = "true"
  this_aws_public_instance_volume_size = 18
  this_aws_public_instance_subnet_id = module.vpc.this_public_subnet_id       
  this_sg_vpc_id = module.vpc.vpc_id                                                      
}                                                                         