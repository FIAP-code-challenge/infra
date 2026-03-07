variable "environment" {
  description = "Nome lógico do ambiente."
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "Região AWS para o ambiente."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome do projeto para padronização de tags e naming."
  type        = string
  default     = "fiap-infra"
}
