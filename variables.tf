variable "vpc_cidr" {}
variable "vpc_name" {}
variable "availability_zone" {}

variable "vpc_id" {
  description = "ID of the VPC to associate the security groups with"
  type        = string
}

variable "public_subnet_config" {
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_subnet_config" {
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "jenkins_http_sg" {
  description = "Name for the security group allowing SSH, HTTP, and HTTPS"
  type        = string
}

variable "jenkins_sg_portopen" {
  description = "Name for the security group allowing port 8080 for Jenkins"
  type        = string
}

