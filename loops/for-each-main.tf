//work on set and map
//create different configuration resourses


resource "aws_instance" "this_aws_instance2" {
    for_each = toset(var.aws_ami)
    ami = each.value
    key_name = "california-key"
    instance_type = "t2.micro"
}   

variable "aws_ami" {
  type = list(string)
  default = [ "ami-05057ffd3a8e2ef62","ami-0a0409af1cb831414","ami-014b33341e3a1178e" ]
               //centos                  //ubantu                  //redhat
}
