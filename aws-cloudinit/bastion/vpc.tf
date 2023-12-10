/*resource "aws_vpc" "app_VPC" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "${local.app_name}_VPC"
  }
}
*/
data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_internet_gateway" "default" {
    internet_gateway_id = var.ig_id
   
}

/*resource "aws_internet_gateway" "app_IG" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Name = "${local.app_name}_IG"
  }

}
*/

resource "aws_subnet" "app_public" {
  vpc_id                  = data.aws_vpc.selected.id
  cidr_block              = var.app_subnet
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${local.app_name}_public"
  }

}

resource "aws_route_table" "app_RT" {
  vpc_id = data.aws_vpc.selected.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.default.id
  }

  tags = {
    Name = "${local.app_name}_RT"
  }
}


resource "aws_route_table_association" "app_RTASN" {
  subnet_id      = aws_subnet.app_public.id
  route_table_id = aws_route_table.app_RT.id
}


resource "tls_private_key" "this" {
  algorithm = "RSA"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "${local.app_name}_KEY"
  public_key = tls_private_key.this.public_key_openssh
}


resource "local_file" "private_key" {
  content         = tls_private_key.this.private_key_pem
  filename        = "${local.app_name}_private_key.pem"
  file_permission = "0600"
}
