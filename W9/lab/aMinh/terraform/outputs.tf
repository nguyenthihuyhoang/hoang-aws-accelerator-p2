output "sns_topic_arn" {
  description = "SNS topic ARN"
  value       = aws_sns_topic.cpu_alert_topic.arn
}

output "alarm_name" {
  description = "CloudWatch alarm name"
  value       = aws_cloudwatch_metric_alarm.ec2_cpu_high.alarm_name
}
