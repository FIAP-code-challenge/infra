variable "environment" {
  description = "Nome lógico do ambiente."
  type        = string
  default     = "prod"
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

variable "vpc_cidr" {
  description = "CIDR da VPC do ambiente."
  type        = string
  default     = "10.20.0.0/16"
}

variable "availability_zones" {
  description = "AZs utilizadas para distribuir as subnets."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  description = "CIDRs das subnets públicas do ambiente."
  type        = list(string)
  default     = ["10.20.0.0/20", "10.20.16.0/20"]
}

variable "private_subnet_cidrs" {
  description = "CIDRs das subnets privadas do ambiente."
  type        = list(string)
  default     = ["10.20.32.0/20", "10.20.48.0/20"]
}

variable "enable_nat_gateway" {
  description = "Define se o ambiente cria NAT Gateway."
  type        = bool
  default     = true
}

variable "enable_ecs_role" {
  description = "Cria roles IAM para ECS."
  type        = bool
  default     = true
}

variable "enable_lambda_role" {
  description = "Cria role IAM para Lambda."
  type        = bool
  default     = false
}

variable "enable_github_oidc" {
  description = "Cria OIDC provider e role para GitHub Actions."
  type        = bool
  default     = false
}

variable "github_org" {
  description = "Organizacao GitHub para trust policy OIDC."
  type        = string
  default     = "FIAP-code-challenge"
}

variable "github_repo" {
  description = "Repositorio GitHub para trust policy OIDC."
  type        = string
  default     = "infra"
}

variable "github_oidc_allowed_subjects" {
  description = "Allowlist de subjects do OIDC para GitHub Actions."
  type        = list(string)
  default = [
    "repo:FIAP-code-challenge/infra:ref:refs/heads/develop",
    "repo:FIAP-code-challenge/infra:ref:refs/heads/main"
  ]
}

variable "ecr_image_tag_mutability" {
  description = "Mutabilidade de tags no ECR."
  type        = string
  default     = "IMMUTABLE"
}

variable "ecr_scan_on_push" {
  description = "Habilita scan ao enviar imagens para o ECR."
  type        = bool
  default     = true
}

variable "ecr_max_image_count" {
  description = "Quantidade maxima de imagens mantidas no ECR."
  type        = number
  default     = 50
}

variable "ecr_force_delete" {
  description = "Permite deletar repositorio ECR com imagens."
  type        = bool
  default     = false
}

variable "container_image_tag" {
  description = "Tag da imagem da API no ECR."
  type        = string
  default     = "bootstrap"
}

variable "api_container_port" {
  description = "Porta do container da API."
  type        = number
  default     = 8080
}

variable "ecs_desired_count" {
  description = "Quantidade desejada de tasks ECS."
  type        = number
  default     = 0
}

variable "ecs_cpu" {
  description = "CPU da task ECS Fargate."
  type        = string
  default     = "512"
}

variable "ecs_memory" {
  description = "Memoria da task ECS Fargate."
  type        = string
  default     = "1024"
}

variable "alb_health_check_path" {
  description = "Path de health check do ALB."
  type        = string
  default     = "/health"
}

variable "ecs_log_retention_days" {
  description = "Retencao de logs da API no CloudWatch."
  type        = number
  default     = 30
}
