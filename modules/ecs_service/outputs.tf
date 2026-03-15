output "cluster_name" {
  description = "Nome do cluster ECS."
  value       = aws_ecs_cluster.this.name
}

output "cluster_arn" {
  description = "ARN do cluster ECS."
  value       = aws_ecs_cluster.this.arn
}

output "service_name" {
  description = "Nome do servico ECS."
  value       = aws_ecs_service.this.name
}

output "task_definition_arn" {
  description = "ARN da task definition ativa."
  value       = aws_ecs_task_definition.this.arn
}

output "alb_dns_name" {
  description = "DNS do Application Load Balancer."
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "ARN do target group da API."
  value       = aws_lb_target_group.this.arn
}

output "ecs_security_group_id" {
  description = "Security group do servico ECS."
  value       = aws_security_group.ecs_service.id
}

output "alb_security_group_id" {
  description = "Security group do ALB."
  value       = aws_security_group.alb.id
}
