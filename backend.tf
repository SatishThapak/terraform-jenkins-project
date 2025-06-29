terraform {
  backend "s3" {
    bucket         = "terraform-statefile-bucket-123456"     
    key            = "s3/terraform.tfstate"     
    region         = "ap-south-1"                                    
     }
}
