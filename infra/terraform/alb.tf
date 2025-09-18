# Load Balancer (ALB)
resource "aws_lb" "North_Virginia-ALB" {
  provider = aws.North_Virginia
  name               = "it-asset-management"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.elb_sg.id]
  subnets = [
    aws_subnet.North_Virginia-Public-Subnet-1.id,
    aws_subnet.North_Virginia-Public-Subnet-2.id
  ]
}

# Target Group for ALB
resource "aws_lb_target_group" "North_Virginia-TG" {
  provider = aws.North_Virginia
  name        = "TG"
  vpc_id      = aws_vpc.North_Virginia-VPC.id
  target_type = "instance"
  protocol    = "HTTP"
  port        = 5000

  health_check {
    protocol            = "HTTP"
    port                = "traffic-port"
    path                = "/"
    matcher             = "200-399"
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }
}

# Listener for ALB
resource "aws_lb_listener" "http" {
  provider = aws.North_Virginia
  load_balancer_arn = aws_lb.North_Virginia-ALB.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.North_Virginia-TG.arn
  }
}

# Attaching Private EC2 Machine From Subnet 1
resource "aws_lb_target_group_attachment" "attach1" {
  provider = aws.North_Virginia
  target_group_arn = aws_lb_target_group.North_Virginia-TG.arn
  target_id        = aws_instance.North_Virginia-Private1-VM.id
  port             = 5000
}

# Attaching Private EC2 Machine From Subnet 2
resource "aws_lb_target_group_attachment" "attach2" {
  provider = aws.North_Virginia
  target_group_arn = aws_lb_target_group.North_Virginia-TG.arn
  target_id        = aws_instance.North_Virginia-Private2-VM.id
  port             = 5000
}


