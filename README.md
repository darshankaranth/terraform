### Usage

```hcl
module "app_instance" {
  source         = "git::https://github.com/darshankaranth/terraform/aws/ref=v0.0.1"
  aws_region     = "us-east-1"
  image_id       = "<ami_id>"
  monitoring     = "<true/false>"
  app_location   = "VIR"
  app_number     = "01"
  env_name       = "sdxcloud"
  env_type       = "PROD"
  component      = "app"
  secure_host_ip = "10.8.0.11/32"
  vpc_cidr       = "10.8.0.0/16"
  app_subnet     = "10.8.1.0/24"
  app_priv_ip    = "10.8.1.10"
}

output "app_public_ip" {
  description = "app public ip"
  value       = module.app_instance.app_public_ip
}

```