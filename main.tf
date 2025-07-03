
module "networking" {
  source                = "./modules/networking"
  vpc_cidr              = var.vpc_cidr
  vpc_name              = var.vpc_name
  public_subnet_config  = var.public_subnet_config
  private_subnet_config = var.private_subnet_config
  availability_zone     = var.availability_zone
}

module "security_groups" {
  source                = "./modules/security-groups"
  vpc_id                = module.networking.vpc_id
  jenkins_openport_22   = "jenkins-sg"
  jenkins_8080          = "jenkins-ui"
  jenkins_instance_id   = module.jenkins_instance.jenkins_instance_id
}


module "jenkins_instance" {
  source                = "./modules/jenkins_instance"
  ami                   = var.ami
  instance_type         = var.instance_type
  vpc_id                = module.networking.vpc_id
  public_key            = var.public_key
  instance_name         = var.instance_name
  subnet_id             = module.networking.public_subnet_ids[0]
  vpc_security_group_ids = [module.security_groups.jenkins_sg_id]
  enable_public_ip_address = true
}

module "load_balancer_target-group" {
  source                   = "./modules/load_balancer_target-group"
  lb_target_group_name     = "jenkins-lb-target-group"
  lb_target_group_port     = "8080"
  lb_target_group_protocol = "HTTP"
  vpc_id                   = module.networking.vpc_id
  target_type              = "instance"
  jenkins_instance_id      = module.jenkins_instance.jenkins_instance_id
}

