terraform {
  backend "s3" {
    bucket = "dev-project-bucket-19062025"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}