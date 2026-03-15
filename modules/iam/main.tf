locals {
  base_tags = merge(var.tags, { module = "iam" })

  github_oidc_subjects = length(var.github_oidc_allowed_subjects) > 0 ? var.github_oidc_allowed_subjects : [
    "repo:${var.github_org}/${var.github_repo}:ref:refs/heads/develop",
    "repo:${var.github_org}/${var.github_repo}:ref:refs/heads/main"
  ]
}

# ─────────────────────────────────────────────
# ECS — Task Execution Role + Task Role
# ─────────────────────────────────────────────

data "aws_iam_policy_document" "ecs_assume_role" {
  count = var.enable_ecs_role ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task_execution" {
  count = var.enable_ecs_role ? 1 : 0

  name               = "${var.name_prefix}-ecs-task-execution"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role[0].json

  tags = merge(local.base_tags, { Name = "${var.name_prefix}-ecs-task-execution" })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_managed" {
  count = var.enable_ecs_role ? 1 : 0

  role       = aws_iam_role.ecs_task_execution[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs_task" {
  count = var.enable_ecs_role ? 1 : 0

  name               = "${var.name_prefix}-ecs-task"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role[0].json

  tags = merge(local.base_tags, { Name = "${var.name_prefix}-ecs-task" })
}

# ─────────────────────────────────────────────
# Lambda — Execution Role
# ─────────────────────────────────────────────

data "aws_iam_policy_document" "lambda_assume_role" {
  count = var.enable_lambda_role ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_execution" {
  count = var.enable_lambda_role ? 1 : 0

  name               = "${var.name_prefix}-lambda-execution"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role[0].json

  tags = merge(local.base_tags, { Name = "${var.name_prefix}-lambda-execution" })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  count = var.enable_lambda_role ? 1 : 0

  role       = aws_iam_role.lambda_execution[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_vpc_access" {
  count = var.enable_lambda_role ? 1 : 0

  role       = aws_iam_role.lambda_execution[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

# ─────────────────────────────────────────────
# GitHub Actions — OIDC (sem credencial estatica)
# ─────────────────────────────────────────────

data "aws_iam_policy_document" "github_oidc_assume_role" {
  count = var.enable_github_oidc ? 1 : 0

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github[0].arn]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = local.github_oidc_subjects
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

data "tls_certificate" "github_actions" {
  count = var.enable_github_oidc ? 1 : 0
  url   = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_openid_connect_provider" "github" {
  count = var.enable_github_oidc ? 1 : 0

  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.github_actions[0].certificates[0].sha1_fingerprint]

  tags = merge(local.base_tags, { Name = "${var.name_prefix}-github-oidc" })
}

resource "aws_iam_role" "github_actions" {
  count = var.enable_github_oidc ? 1 : 0

  name                 = "${var.name_prefix}-github-actions"
  assume_role_policy   = data.aws_iam_policy_document.github_oidc_assume_role[0].json
  max_session_duration = 3600

  tags = merge(local.base_tags, { Name = "${var.name_prefix}-github-actions" })
}
