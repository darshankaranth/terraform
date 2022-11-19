variable "image_id" {
  type        = string
  description = "AWS ami id"
}

locals {
  app_name = "${var.env_name}-AWS-${var.app_location}-${var.app_number}"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "env_name" {
  type        = string
  description = "app environment name"
}

variable "env_type" {
  type        = string
  description = "app environment type"
}

variable "app_location" {
  type        = string
  description = "app location code"
}

variable "app_number" {
  type        = string
  description = "app number"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
}

variable "app_subnet" {
  type        = string
  description = "app subnet"
}

variable "app_priv_ip" {
  type        = string
  description = "app private IP"
}

variable "secure_host_ip" {
  type        = string
  description = "Bastion ip"
}

variable "monitoring" {
  type        = string
  description = "Enable detailed monitoring"
}