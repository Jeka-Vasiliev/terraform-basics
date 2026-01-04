output "subnet_id" {
  value       = module.network_dev.subnet_id
  description = "The ID of the public subnet"
}

output "subnet_arn" {
  value       = module.network_dev.subnet_arn
  description = "The ARN of the public subnet"
}

output "app_sg_id" {
  value       = module.network_dev.app_sg_id
  description = "The ID of the application security group"
}
