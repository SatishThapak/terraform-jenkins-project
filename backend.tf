terraform {
  backend "s3" {
    bucket         = "terraform-statefile-bucket-123456"     # your real bucket name
    key            = "global/s3/terraform.tfstate"     # can change to suit project
    region         = "ap-south-1"                       # match region
    dynamodb_table = "terraform-locks"                 # name of your DynamoDB table
    encrypt        = true
  }
}