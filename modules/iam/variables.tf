variable "name_prefix" {
  description = "Prefixo usado no naming das roles e policies IAM."
  type        = string
}

variable "enable_ecs_role" {
  description = "Cria role para tasks ECS (task execution + task role)."
  type        = bool
  default     = false
}

variable "enable_lambda_role" {
  description = "Cria role para execucao de funcoes Lambda."
  type        = bool
  default     = false
}

variable "enable_github_oidc" {
  description = "Cria OIDC provider e role para GitHub Actions sem credenciais estaticas."
  type        = bool
  default     = false

  validation {
    condition = (!var.enable_github_oidc) || (
      length(var.github_oidc_allowed_subjects) > 0 || (var.github_org != "" && var.github_repo != "")
    )
    error_message = "Quando enable_github_oidc for true, defina github_oidc_allowed_subjects ou informe github_org e github_repo."
  }
}

variable "github_org" {
  description = "Organizacao GitHub para a trust policy do OIDC (ex: FIAP-code-challenge)."
  type        = string
  default     = ""
}

variable "github_repo" {
  description = "Repositorio GitHub para a trust policy do OIDC (ex: infra)."
  type        = string
  default     = ""
}

variable "github_oidc_allowed_subjects" {
  description = "Lista de subjects permitidos no claim sub do GitHub OIDC. Ex.: repo:org/repo:ref:refs/heads/develop"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags aplicadas aos recursos IAM."
  type        = map(string)
  default     = {}
}
