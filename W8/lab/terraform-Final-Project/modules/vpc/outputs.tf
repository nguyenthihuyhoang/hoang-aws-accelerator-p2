output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the created VPC"
}

output "public_subnet_id" {
  value       = aws_subnet.public.id
  description = "The ID of the public subnet"
}

output "private_subnet_id" {
  value       = aws_subnet.private_1.id
  description = "The ID of the first private subnet"
}

output "private_subnet_ids" {
  value       = [aws_subnet.private_1.id, aws_subnet.private_2.id]
  description = "List of private subnet IDs for Multi-AZ RDS DB Subnet Group"
}
