locals {
  computed_public_subnet_cidrs  = [for idx in range(length(var.azs)) : cidrsubnet(var.vpc_cidr, 4, idx)]
  computed_private_subnet_cidrs = [for idx in range(length(var.azs)) : cidrsubnet(var.vpc_cidr, 4, idx + length(var.azs))]

  public_subnet_cidrs  = length(var.public_subnet_cidrs) > 0 ? var.public_subnet_cidrs : local.computed_public_subnet_cidrs
  private_subnet_cidrs = length(var.private_subnet_cidrs) > 0 ? var.private_subnet_cidrs : local.computed_private_subnet_cidrs

  public_subnets_by_az = {
    for idx, az in var.azs :
    az => {
      az   = az
      cidr = local.public_subnet_cidrs[idx]
    }
  }

  private_subnets_by_az = {
    for idx, az in var.azs :
    az => {
      az   = az
      cidr = local.private_subnet_cidrs[idx]
    }
  }

  base_tags = merge(
    var.tags,
    {
      module = "vpc"
    }
  )
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    local.base_tags,
    {
      Name = "${var.name_prefix}-vpc"
    }
  )
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    local.base_tags,
    {
      Name = "${var.name_prefix}-igw"
    }
  )
}

resource "aws_subnet" "public" {
  for_each = local.public_subnets_by_az

  vpc_id                  = aws_vpc.this.id
  availability_zone       = each.value.az
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = true

  tags = merge(
    local.base_tags,
    {
      Name = "${var.name_prefix}-public-${each.value.az}"
      tier = "public"
    }
  )
}

resource "aws_subnet" "private" {
  for_each = local.private_subnets_by_az

  vpc_id            = aws_vpc.this.id
  availability_zone = each.value.az
  cidr_block        = each.value.cidr

  tags = merge(
    local.base_tags,
    {
      Name = "${var.name_prefix}-private-${each.value.az}"
      tier = "private"
    }
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    local.base_tags,
    {
      Name = "${var.name_prefix}-rt-public"
    }
  )
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  count = var.enable_nat_gateway ? 1 : 0

  domain = "vpc"

  tags = merge(
    local.base_tags,
    {
      Name = "${var.name_prefix}-nat-eip"
    }
  )
}

resource "aws_nat_gateway" "this" {
  count = var.enable_nat_gateway ? 1 : 0

  allocation_id = aws_eip.nat[0].id
  subnet_id     = values(aws_subnet.public)[0].id

  tags = merge(
    local.base_tags,
    {
      Name = "${var.name_prefix}-nat"
    }
  )

  depends_on = [aws_internet_gateway.this]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    local.base_tags,
    {
      Name = "${var.name_prefix}-rt-private"
    }
  )
}

resource "aws_route" "private_nat_access" {
  count = var.enable_nat_gateway ? 1 : 0

  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[0].id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}
