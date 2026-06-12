terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = var.region
}

# SNS Topic
resource "aws_sns_topic" "cpu_alert_topic" {
  name = var.sns_topic_name
}

# SNS Email Subscription
resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.cpu_alert_topic.arn
  protocol  = "email"
  endpoint  = var.email_address
}

# CloudWatch Alarm for EC2 CPU Utilization
resource "aws_cloudwatch_metric_alarm" "ec2_cpu_high" {
  alarm_name          = var.alarm_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300 # 5 minutes
  statistic           = "Average"
  threshold           = var.threshold
  alarm_description   = "Alarm when EC2 CPU exceeds 80% for 5 minutes"
  alarm_actions       = [aws_sns_topic.cpu_alert_topic.arn]
  dimensions = {
    InstanceId = var.instance_id
  }
}
