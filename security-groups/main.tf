variable "jenkins_http_sg" {}
variable "vpc_id" {}
variable "jenkins_sg_portopen" {}

# SG for SSH, HTTP, and HTTPS
resource "aws_security_group" "sg_for_jenkins" {
  name        = var.jenkins_http_sg
  description = "Allow SSH (22), HTTP (80), and HTTPS (443)"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.jenkins_http_sg
  }
}

# SG for Jenkins (Port 8080)
resource "aws_security_group" "jenkins_port_8080" {
  name        = var.jenkins_sg_portopen
  description = "Allow traffic to Jenkins on port 8080"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow access to Jenkins on port 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.jenkins_sg_portopen
  }
}

