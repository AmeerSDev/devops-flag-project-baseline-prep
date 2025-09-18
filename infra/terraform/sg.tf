resource "aws_security_group" "elb_sg" {
  provider = aws.North_Virginia
  name        = "elb-sg"
  description = "ELB ingress from Internet, egress to apps"
  vpc_id      = aws_vpc.North_Virginia-VPC.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { # to apps
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ansible_sg" {
  provider = aws.North_Virginia
  name        = "ansible-sg"
  description = "SSH from admin, SSH to private"
  vpc_id      = aws_vpc.North_Virginia-VPC.id

  ingress {
    description = "SSH from your IP Address"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { # allow SSH to private hosts + package installs, etc.
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "app_sg" {
  provider = aws.North_Virginia
  name        = "app-sg"
  description = "App hosts: SSH from Ansible, app from ELB"
  vpc_id      = aws_vpc.North_Virginia-VPC.id

  # SSH from Ansible SG
  ingress {
    description     = "SSH from Ansible"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.ansible_sg.id]
  }

  # HTTP from Ansible SG for Curl Debugging
  ingress {
    description     = "HTTP from Ansible"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.ansible_sg.id]
  }

  # Flask on port 6000 from ELB
  ingress {
    description     = "App from ELB"
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.elb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}