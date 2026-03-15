output "environment" {
  description = "Ambiente atual."
  value       = var.environment
}

output "name_prefix" {
  description = "Prefixo padrão para recursos do ambiente."
  value       = local.name_prefix
}

output "vpc_id" {
  description = "ID da VPC do ambiente."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs das subnets públicas do ambiente."
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs das subnets privadas do ambiente."
  value       = module.vpc.private_subnet_ids
}

output "ecs_task_execution_role_arn" {
  description = "ARN da ECS Task Execution Role."
  value       = module.iam.ecs_task_execution_role_arn
}

output "ecs_task_role_arn" {
  description = "ARN da ECS Task Role."
  value       = module.iam.ecs_task_role_arn
}

output "lambda_execution_role_arn" {
  description = "ARN da Lambda Execution Role."
  value       = module.iam.lambda_execution_role_arn
}

output "github_actions_role_arn" {
  description = "ARN da role GitHub Actions (OIDC)."
  value       = module.iam.github_actions_role_arn
}

output "ecr_repository_url" {
  description = "URL do repositorio ECR da API."
  value       = module.ecr.repository_url
}

output "ecs_cluster_name" {
  description = "Nome do cluster ECS."
  value       = module.ecs_service.cluster_name
}

output "ecs_service_name" {
  description = "Nome do servico ECS da API."
  value       = module.ecs_service.service_name
}

output "alb_dns_name" {
  description = "DNS publico do ALB da API."
  value       = module.ecs_service.alb_dns_name
}
