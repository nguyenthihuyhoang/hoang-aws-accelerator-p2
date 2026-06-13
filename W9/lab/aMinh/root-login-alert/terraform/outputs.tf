output "sns_topic_arn" {
  description = "SNS topic ARN"
  value       = aws_sns_topic.root_login_topic.arn
}

output "alarm_name" {
  description = "CloudWatch alarm name"
  value       = aws_cloudwatch_metric_alarm.root_login_alarm.alarm_name
}

output "metric_name" {
  description = "CloudWatch metric name from filter"
  value       = aws_cloudwatch_metric_filter.root_login_filter.metric_transformation[0].name
}
