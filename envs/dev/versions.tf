terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  cloud {
    organization = "FIAP-tech-challenge-oficina"

    workspaces {
      name = "api-oficina-dev"
    }
  }
}
