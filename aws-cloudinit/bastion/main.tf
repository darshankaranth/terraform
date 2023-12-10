provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Environment = "${var.env_name}"
      Type        = "${var.env_type}"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.23.0"
    }
  }

  required_version = ">=1.1.9"
}

resource "aws_network_interface" "app" {
  subnet_id       = aws_subnet.app_public.id
  private_ips     = [var.app_priv_ip]
  security_groups = [aws_security_group.app.id]

  tags = {
    Name = local.app_name
  }
}

data "template_file" "user_data" {
  template = file("${path.cwd}/cloudinit.yaml")
}

resource "aws_instance" "app" {
  ami           = var.image_id
  instance_type = "c5.xlarge"
  key_name      = module.key_pair.key_pair_name
  monitoring    = var.monitoring
  user_data     = data.template_file.user_data.rendered
  network_interface {
    network_interface_id = aws_network_interface.app.id
    device_index         = 0
  }
  ebs_block_device {
    device_name           = "/dev/sda1"
    volume_size           = "20"
    volume_type           = "gp2"
    encrypted             = false
    delete_on_termination = true
  }

  lifecycle {
    ignore_changes = [ebs_block_device]
  }
  tags = {
    Name = local.app_name
  }

}

resource "aws_eip" "app_eip" {
  instance = aws_instance.app.id
  vpc      = true
  tags = {
    Name = local.app_name
  }

}
output "eip" {
  description = "Contains the public IP address"
  value       = aws_eip.app_eip.public_ip
} 
