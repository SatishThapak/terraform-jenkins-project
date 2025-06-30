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

variable "ami_id" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "tag_name" {
  type = string
}
variable "public_key" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "enable_public_ip_address" {
  type = string
}
variable "user_data_install_jenkins" {
  type = string
}
