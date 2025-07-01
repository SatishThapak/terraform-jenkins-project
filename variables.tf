variable "vpc_cidr" {}
variable "vpc_name" {}
variable "availability_zone" {}

variable "vpc_id" {
  type    = string
  default = null
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
