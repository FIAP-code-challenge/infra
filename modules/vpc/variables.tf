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
}

variable "public_subnet_cidrs" {
  description = "CIDRs das subnets publicas. Se vazio, sera calculado automaticamente."
  type        = list(string)
  default     = []
}

variable "private_subnet_cidrs" {
  description = "CIDRs das subnets privadas. Se vazio, sera calculado automaticamente."
  type        = list(string)
  default     = []
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
