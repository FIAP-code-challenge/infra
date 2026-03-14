output "ecs_task_execution_role_arn" {
  description = "ARN da ECS Task Execution Role."
  value       = try(aws_iam_role.ecs_task_execution[0].arn, null)
}

output "ecs_task_role_arn" {
  description = "ARN da ECS Task Role."
  value       = try(aws_iam_role.ecs_task[0].arn, null)
}

output "lambda_execution_role_arn" {
  description = "ARN da Lambda Execution Role."
  value       = try(aws_iam_role.lambda_execution[0].arn, null)
}

output "github_actions_role_arn" {
  description = "ARN da role para GitHub Actions via OIDC."
  value       = try(aws_iam_role.github_actions[0].arn, null)
}
