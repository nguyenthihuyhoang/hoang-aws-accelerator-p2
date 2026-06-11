variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "public_cidr" {
  type        = string
  description = "The CIDR block for the public subnet"
}

variable "private_cidr" {
  type        = string
  description = "The CIDR block for the private subnet"
}

variable "region" {
  type        = string
  description = "The AWS region"
  default     = "ap-southeast-1"
}

variable "env" {
  type        = string
  description = "The environment name (e.g. prod, dev)"
}
