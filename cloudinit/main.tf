module "bastion_instance" {
  source         = "./bastion"
  aws_region     = "ap-south-1"
  image_id       = "<AMI_ID>"
  monitoring     = "false"
  app_location   = "MUM"
  app_number     = "Bastion"
  env_name       = "QA"
  env_type       = "NONPROD"
  vpc_id         = "<Existing VPC ID>"
  secure_host_ip = "10.8.0.11/32"
  vpc_cidr       = "10.8.0.0/16"
  app_subnet     = "10.8.2.0/24"
  app_priv_ip    = "10.8.2.10"
}

output "app_public_ip" {
  description = "app public ip"
  value       = module.bastion_instance.eip
}
