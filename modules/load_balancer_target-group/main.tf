resource "aws_lb_target_group" "lb_grp" {
  name        = var.lb_target_group_name
  port        = var.lb_target_group_port
  protocol    = var.lb_target_group_protocol
  target_type = var.target_type
  vpc_id      = var.vpc_id

  health_check {
    path                = "/login"
    port                = "8080"
    healthy_threshold   = 6
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = "200"
  }

  tags = {
    Name = var.lb_target_group_name
  }
}

resource "aws_lb_target_group_attachment" "lb_target_attach" {
  target_group_arn = aws_lb_target_group.lb_grp.arn
  target_id        = var.jenkins_instance_id
  port             = 8080
}
