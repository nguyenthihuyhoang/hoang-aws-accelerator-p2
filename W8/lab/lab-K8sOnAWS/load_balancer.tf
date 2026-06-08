# 1. Application Load Balancer
resource "aws_lb" "k8s_alb" {
  name               = "k8s-lab-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = data.aws_subnets.default.ids

  tags = {
    Name = "${var.project_name}-alb"
  }
}

# 2. ALB Target Group (Pointing to Port 30000 on EC2)
resource "aws_lb_target_group" "k8s_tg" {
  name     = "k8s-lab-tg"
  port     = 30000
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    port                = "30000"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 5
    interval            = 10
  }

  tags = {
    Name = "${var.project_name}-tg"
  }
}

# 3. HTTP Listener
resource "aws_lb_listener" "http_front_end" {
  load_balancer_arn = aws_lb.k8s_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.k8s_tg.arn
  }
}

# 4. Target Group Attachment
resource "aws_lb_target_group_attachment" "k8s_ec2" {
  target_group_arn = aws_lb_target_group.k8s_tg.arn
  target_id        = aws_instance.k8s_node.id
  port             = 30000
}
