
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
  jenkins_instance_id      = module.jenkins_instance.jenkins_instance_id
}

module "alb" {
  source                    = "./load-balancer"
  lb_name                   = "dev-proj-1-alb"
  is_external               = false
  lb_type                   = "application"
  sg_enable_ssh_https       = module.security_group.sg_ec2_sg_ssh_http_id
  subnet_ids                = tolist(module.networking.dev_proj_1_public_subnets)
  tag_name                  = "dev-proj-1-alb"
  lb_target_group_arn       = module.lb_target_group.dev_proj_1_lb_target_group_arn
  ec2_instance_id           = module.jenkins.jenkins_ec2_instance_ip
  lb_listner_port           = 80
  lb_listner_protocol       = "HTTP"
  lb_listner_default_action = "forward"
  lb_https_listner_port     = 443
  lb_https_listner_protocol = "HTTPS"
  dev_proj_1_acm_arn        = module.aws_ceritification_manager.dev_proj_1_acm_arn
  lb_target_group_attachment_port = 8080
}