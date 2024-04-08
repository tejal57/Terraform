output "my_vpc_cidr" {
 value = aws_vpc.this_aws_vpc.cidr_block
}

output "public_subnet_cidr" {
 value =aws_subnet.this_public_subnet.cidr_block
}


output "private_subnet_cidr" {
 value =aws_subnet.this_private_subnet.cidr_block
}

output "this_public_subnet_id" {
  value = aws_subnet.this_public_subnet.id
}

output "vpc_id" {
  value = aws_vpc.this_aws_vpc.id
}