resource "aws_s3_bucket" "s3_bucket" {
  bucket = "dev-project-bucket-19062025"
  tags = {
    Name        = "dev-project-bucket-19062025"
    environment = "Dev"
  }
}

terraform {
  backend "s3" {
    bucket = "dev-project-bucket-19062025"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-locks"
  }
}