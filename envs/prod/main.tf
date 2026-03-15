module "bootstrap" {
  source = "../../modules/bootstrap"

  project_name = var.project_name
  environment  = var.environment
}

module "vpc" {
  source = "../../modules/vpc"

  name_prefix          = local.name_prefix
  vpc_cidr             = var.vpc_cidr
  azs                  = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  enable_nat_gateway   = var.enable_nat_gateway
  tags                 = local.default_tags
}

module "iam" {
  source = "../../modules/iam"

  name_prefix        = local.name_prefix
  enable_ecs_role    = var.enable_ecs_role
  enable_lambda_role = var.enable_lambda_role
  enable_github_oidc = var.enable_github_oidc
  github_org         = var.github_org
  github_repo        = var.github_repo
  github_oidc_allowed_subjects = var.github_oidc_allowed_subjects
  tags               = local.default_tags
}
