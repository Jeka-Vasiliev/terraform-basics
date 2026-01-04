output "subnet_id" {
  value       = aws_subnet.public.id
  description = "The ID of the public subnet"
}

output "subnet_arn" {
  value       = aws_subnet.public.arn
  description = "The ARN of the public subnet"
}

output "app-sg_id" {
  value       = aws_security_group.app-sg.id
  description = "The ID of the application security group"
}
