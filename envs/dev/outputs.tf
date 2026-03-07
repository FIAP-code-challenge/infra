output "environment" {
  description = "Ambiente atual."
  value       = var.environment
}

output "name_prefix" {
  description = "Prefixo padrão para recursos do ambiente."
  value       = local.name_prefix
}
