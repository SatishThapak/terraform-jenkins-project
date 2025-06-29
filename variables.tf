variable "vpc_cidr" {}
variable "vpc_name" {}
variable "availability_zone" {}


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

