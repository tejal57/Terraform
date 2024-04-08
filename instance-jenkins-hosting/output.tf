output "aws_public_ip" {
  value = aws_instance.this_aws_instance.public_ip
}

output "aws_private_ip" {
  value = aws_instance.this_aws_instance.private_ip
}

output "aws_arn" {
  value = aws_instance.this_aws_instance.arn
}

output "aws_instance_id" {
  value = aws_instance.this_aws_instance.id
}

output "aws_private_dns" {
  value = aws_instance.this_aws_instance.private_dns
}

output "aws_public_dns" {
  value = aws_instance.this_aws_instance.public_dns
}