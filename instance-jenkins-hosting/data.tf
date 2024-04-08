data "aws_ami" "this_ami" {
  name_regex = "my_iam"
  filter {
    name   = "name"
    values = ["my_iam"]
  }

}
  