terraform {
  backend "s3" {
    bucket = "tejal-terraform-buket"
    key    = "terraform.tfstate"
    region = "us-west-1"
    dynamodb_table = "terraform-lock2"
    
  }
}