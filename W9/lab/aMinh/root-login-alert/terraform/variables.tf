variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cloudtrail_name" {
  description = "Name of the CloudTrail trail"
  type        = string
  default     = "root-login-trail"
}

variable "s3_bucket_name" {
  description = "S3 bucket for CloudTrail logs"
  type        = string
  default     = "root-login-cloudtrail-logs-${random_id.bucket_suffix.hex}"
}

variable "cloudwatch_log_group_name" {
  description = "CloudWatch log group for CloudTrail"
  type        = string
  default     = "/aws/cloudtrail/root-login"
}

variable "metric_filter_name" {
  description = "Name of the CloudWatch metric filter"
  type        = string
  default     = "RootAccountLoginCountFilter"
}

variable "metric_name" {
  description = "CloudWatch metric name for root login events"
  type        = string
  default     = "RootAccountLoginCount"
}

variable "metric_namespace" {
  description = "CloudWatch metric namespace"
  type        = string
  default     = "Security"
}

variable "sns_topic_name" {
  description = "SNS topic name for root login alerts"
  type        = string
  default     = "root-login-alert-topic"
}

variable "email_address" {
  description = "Email address to notify"
  type        = string
}

variable "alarm_name" {
  description = "CloudWatch alarm name for root login"
  type        = string
  default     = "root-account-login-alarm"
}
