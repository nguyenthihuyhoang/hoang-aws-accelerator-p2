output "web_public_ip" {
  value       = aws_instance.web.public_ip
  description = "The public IP of the web server"
}

output "rds_endpoint" {
  value       = aws_db_instance.mysql.endpoint
  description = "The connection endpoint for the RDS MySQL instance"
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.static_assets.id
  description = "The name of the S3 bucket"
}
