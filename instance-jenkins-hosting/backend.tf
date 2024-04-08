terraform {
    backend "s3" {
        bucket = "tejal-terraform-backup"
        key = "terraform.tfstate"
        region = "us-west-1"
       
    }
}
