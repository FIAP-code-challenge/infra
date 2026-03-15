variable "name_prefix" {
  description = "Prefixo usado no naming dos recursos de rede."
  type        = string
}

variable "vpc_cidr" {
  description = "Bloco CIDR principal da VPC."
  type        = string
}

variable "azs" {
  description = "Lista de AZs para criar subnets."
  type        = list(string)

  validation {
     condition     = length(var.azs) > 0 && length(distinct(var.azs)) == length(var.azs)
     error_message = "A lista de AZs (var.azs) nao pode ser vazia e nao pode conter valores duplicados."
   }
}

variable "public_subnet_cidrs" {
  description = "CIDRs das subnets publicas. Se vazio, sera calculado automaticamente."
  type        = list(string)
  default     = []

  validation {
     condition     = length(var.public_subnet_cidrs) == 0 || length(var.public_subnet_cidrs) == length(var.azs)
     error_message = "public_subnet_cidrs deve ser vazio (para calculo automatico) ou ter o mesmo tamanho de azs."
   }
}

variable "private_subnet_cidrs" {
  description = "CIDRs das subnets privadas. Se vazio, sera calculado automaticamente."
  type        = list(string)
  default     = []

   validation {
     condition     = length(var.private_subnet_cidrs) == 0 || length(var.private_subnet_cidrs) == length(var.azs)
     error_message = "private_subnet_cidrs deve ser vazio (para calculo automatico) ou ter o mesmo tamanho de azs."
   }
}

variable "enable_nat_gateway" {
  description = "Habilita NAT Gateway para saida das subnets privadas."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags extras aplicadas aos recursos da VPC."
  type        = map(string)
  default     = {}
}
