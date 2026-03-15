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

variable "vpc_cidr" {
  description = "CIDR da VPC do ambiente."
  type        = string
  default     = "10.10.0.0/16"
}

variable "availability_zones" {
  description = "AZs utilizadas para distribuir as subnets."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  description = "CIDRs das subnets públicas do ambiente."
  type        = list(string)
  default     = ["10.10.0.0/20", "10.10.16.0/20"]
}

variable "private_subnet_cidrs" {
  description = "CIDRs das subnets privadas do ambiente."
  type        = list(string)
  default     = ["10.10.32.0/20", "10.10.48.0/20"]
}

variable "enable_nat_gateway" {
  description = "Define se o ambiente cria NAT Gateway."
  type        = bool
  default     = false
}

variable "enable_ecs_role" {
  description = "Cria roles IAM para ECS."
  type        = bool
  default     = false
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
