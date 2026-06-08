variable "aws_region" {
  type        = string
  default     = "ap-southeast-1"
  description = "AWS region for resources"
}

variable "instance_type" {
  type        = string
  default     = "t3.medium"
  description = "EC2 instance size for Minikube node"
}

variable "ssh_key_name" {
  type        = string
  default     = "k8s-lab-key"
  description = "Name of the SSH Key Pair"
}

variable "volume_size" {
  type        = number
  default     = 30
  description = "EC2 root volume size in GB"
}

variable "project_name" {
  type        = string
  default     = "K8s-Minikube-Lab"
  description = "Project name tag for tagging resources"
}
