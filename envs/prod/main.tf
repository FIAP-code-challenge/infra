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

  name_prefix                  = local.name_prefix
  enable_ecs_role              = var.enable_ecs_role
  enable_lambda_role           = var.enable_lambda_role
  enable_github_oidc           = var.enable_github_oidc
  github_org                   = var.github_org
  github_repo                  = var.github_repo
  github_oidc_allowed_subjects = var.github_oidc_allowed_subjects
  tags                         = local.default_tags
}

module "ecr" {
  source = "../../modules/ecr"

  name_prefix          = local.name_prefix
  repository_name      = "${local.name_prefix}-api"
  image_tag_mutability = var.ecr_image_tag_mutability
  scan_on_push         = var.ecr_scan_on_push
  max_image_count      = var.ecr_max_image_count
  force_delete         = var.ecr_force_delete
  tags                 = local.default_tags
}

module "ecs_service" {
  source = "../../modules/ecs_service"

  name_prefix            = local.name_prefix
  vpc_id                 = module.vpc.vpc_id
  public_subnet_ids      = module.vpc.public_subnet_ids
  private_subnet_ids     = module.vpc.private_subnet_ids
  container_image        = "${module.ecr.repository_url}:${var.container_image_tag}"
  container_port         = var.api_container_port
  desired_count          = var.ecs_desired_count
  cpu                    = var.ecs_cpu
  memory                 = var.ecs_memory
  health_check_path      = var.alb_health_check_path
  log_retention_days     = var.ecs_log_retention_days
  execution_role_arn     = module.iam.ecs_task_execution_role_arn
  task_role_arn          = module.iam.ecs_task_role_arn
  enable_execute_command = true
  assign_public_ip       = false
  tags                   = local.default_tags
}
