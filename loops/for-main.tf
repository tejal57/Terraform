//generally used in output block

output "aws_public_ip" {
  value = [for instance in var.aws_ami:
  aws_instance.this_aws_instance2[instance].public_ip]
}