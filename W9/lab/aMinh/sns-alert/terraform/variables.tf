variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "sns_topic_name" {
  description = "SNS topic name for CPU alerts"
  type        = string
  default     = "cpu-alert-topic"
}

variable "email_address" {
  description = "Email address to subscribe to SNS topic"
  type        = string
}

variable "instance_id" {
  description = "EC2 Instance ID to monitor"
  type        = string
}

variable "alarm_name" {
  description = "CloudWatch alarm name"
  type        = string
  default     = "ec2-cpu-high-80pct"
}

variable "threshold" {
  description = "CPU threshold percent"
  type        = number
  default     = 80
}
