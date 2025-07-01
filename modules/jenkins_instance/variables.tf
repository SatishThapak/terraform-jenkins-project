variable "ami" {}
variable "instance_type" {}
variable "vpc_id" {}
variable "public_key" {}
variable "instance_name" {}
variable "subnet_id" {}
variable "vpc_security_group_ids" {
  type = list(string)
}