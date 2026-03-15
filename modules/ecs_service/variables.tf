variable "name_prefix" {
  description = "Prefixo base para naming dos recursos."
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC onde o servico sera implantado."
  type        = string
}

variable "public_subnet_ids" {
  description = "Subnets publicas para ALB."
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Subnets privadas para tasks ECS."
  type        = list(string)
}

variable "container_image" {
  description = "Imagem do container da API (ECR ou registry compativel)."
  type        = string
}

variable "container_port" {
  description = "Porta do container da aplicacao."
  type        = number
  default     = 8080
}

variable "desired_count" {
  description = "Quantidade desejada de tasks do servico ECS."
  type        = number
  default     = 0
}

variable "cpu" {
  description = "CPU da task ECS (Fargate)."
  type        = string
  default     = "256"
}

variable "memory" {
  description = "Memoria da task ECS (Fargate)."
  type        = string
  default     = "512"
}

variable "health_check_path" {
  description = "Path de health check do ALB target group."
  type        = string
  default     = "/health"
}

variable "log_retention_days" {
  description = "Dias de retencao de logs no CloudWatch."
  type        = number
  default     = 14
}

variable "execution_role_arn" {
  description = "ARN da task execution role do ECS."
  type        = string
}

variable "task_role_arn" {
  description = "ARN da task role do ECS."
  type        = string
}

variable "enable_execute_command" {
  description = "Habilita ECS Exec para diagnostico das tasks."
  type        = bool
  default     = true
}

variable "assign_public_ip" {
  description = "Define se tasks recebem IP publico."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags aplicadas aos recursos."
  type        = map(string)
  default     = {}
}
