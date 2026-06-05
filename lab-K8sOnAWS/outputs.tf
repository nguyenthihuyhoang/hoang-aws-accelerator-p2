output "app_url" {
  value       = "http://${aws_lb.k8s_alb.dns_name}"
  description = "Truy cập URL này trên trình duyệt để xem app"
}

output "ec2_public_ip" {
  value       = aws_instance.k8s_node.public_ip
  description = "Địa chỉ IP public của EC2 để SSH"
}
