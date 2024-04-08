//work on index

resource "aws_iam_user" "this_iam" {
  name = "linux.${count.index}"
  count =  3
  path = "/"

  tags = {
    tag-key = "tej"
  }

}

//OR

resource "aws_iam_user" "this_iam2" {
  name = var.this_iam_users_list[count.index]
  count = length(var.this_iam_users_list)
} 

variable "this_iam_users_list" {
  type = list(string)
  default = [ "tej", "div" , "sid", "adi" ]
}



//disadvantage - count loop in Terraform  modify an existing resource instead of creating a new it's generally not recommended due to the limitations and potential risks involved


resource "aws_instance" "this_aws_instance" {
    ami = "ami-05057ffd3a8e2ef62"
    //vpc_security_group_ids = ["sg-0a2e896f62230ee34"]
    key_name = "california-key"
    instance_type = "t2.micro"
    count = 2
}   
