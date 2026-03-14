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
  description = "CIDRs das subnets publicas do ambiente."
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
