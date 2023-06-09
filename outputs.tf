output "alb_sg_id" {
  value       = aws_security_group.alb_sg.id
  description = "The ID of the ALB Security Group."
}

output "asg_sg_id" {
  value       = aws_security_group.asg_sg.id
  description = "The ID of the ASG Security Group."
}

output "db_sg_id" {
  value       = aws_security_group.db_sg.id
  description = "The ID of the database Security Group."
}

output "asg_arn" {
  value       = module.asg.autoscaling_group_arn
  description = "The ARN of the ASG."
}

output "asg_id" {
  value       = module.asg.autoscaling_group_id
  description = "The ID of the ASG."
}

output "asg_name" {
  value       = module.asg.autoscaling_group_name
  description = "The name of the ASG."
}

output "alb_arn" {
  value       = module.alb.lb_arn
  description = "The ARN of the ALB."
}

output "alb_arn_suffix" {
  value       = module.alb.lb_arn_suffix
  description = "The ARN suffix of the ALB."
}

output "alb_id" {
  value       = module.alb.lb_id
  description = "The ID of the ALB."
}

output "alb_dns_name" {
  value       = module.alb.lb_dns_name
  description = "The DNS name of the ALB."
}

output "db_arn" {
  value       = module.rds.db_instance_arn
  description = "The ARN of the RDS instance."
}

output "db_id" {
  value       = module.rds.db_instance_id
  description = "The ID of the RDS instance."
}

output "db_host" {
  value       = module.rds.db_instance_address
  description = "The host of the RDS instance."
}

output "db_az" {
  value       = module.rds.db_instance_availability_zone
  description = "The availability zone of the RDS instance."
}
