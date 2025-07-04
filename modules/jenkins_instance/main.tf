resource "aws_instance" "jenkins_instance" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.jenkins_key.key_name
  subnet_id = var.subnet_id
  associate_public_ip_address = var.enable_public_ip_address
  vpc_security_group_ids = var.vpc_security_group_ids
    tags = {
    Name = var.instance_name
  }
  user_data = file("/home/qolsysjci/myterraform/terraform-jenkins-project/modules/scripts/install-jenkins.sh")

  }

resource "tls_private_key" "jenkins_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "jenkins_key" {
  key_name   = "jenkins-key"
  public_key = tls_private_key.jenkins_key.public_key_openssh
}

resource "local_file" "private_key" {
  filename        = "${path.module}/jenkins-key.pem"
  content         = tls_private_key.jenkins_key.private_key_pem
  file_permission = "0400"
}
