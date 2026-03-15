variable "name_prefix" {
  description = "Prefixo base para naming de recursos."
  type        = string
}

variable "repository_name" {
  description = "Nome do repositorio ECR."
  type        = string
}

variable "image_tag_mutability" {
  description = "Mutabilidade de tags no ECR (MUTABLE ou IMMUTABLE)."
  type        = string
  default     = "IMMUTABLE"

  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "image_tag_mutability deve ser MUTABLE ou IMMUTABLE."
  }
}

variable "scan_on_push" {
  description = "Habilita scan de vulnerabilidades ao enviar imagem."
  type        = bool
  default     = true
}

variable "max_image_count" {
  description = "Quantidade maxima de imagens mantidas no repositorio."
  type        = number
  default     = 10

  validation {
    condition     = var.max_image_count > 0
    error_message = "max_image_count deve ser maior que zero."
  }
}

variable "force_delete" {
  description = "Permite deletar repositorio mesmo com imagens (usar com cautela)."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags aplicadas ao repositorio ECR."
  type        = map(string)
  default     = {}
}
