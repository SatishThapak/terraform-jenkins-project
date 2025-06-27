resource "aws_s3_bucket" "s3_bucket" {
  bucket = "dev-project-bucket-19062025"
  tags = {
    Name        = "dev-project-bucket-19062025"
    environment = "Dev"
  }
}
