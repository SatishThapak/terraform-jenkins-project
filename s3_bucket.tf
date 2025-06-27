# S3 bucket for storing Terraform state
resource "aws_s3_bucket" "tf_state" {
  bucket = "terraform-statefile-bucket-123456" 

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "Terraform Statefile Bucket"
    Environment = "Dev"
  }
}

