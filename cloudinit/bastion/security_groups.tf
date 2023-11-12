resource "aws_security_group" "app" {

  name        = "${local.app_name}_app_sg"
  description = "Security group for app"
  vpc_id      = data.aws_vpc.selected.id

  egress {

    from_port   = 0
    to_port     = 65535
    protocol    = "all"
    description = "Open internet"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Allow SSH"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
