output "vpc_id" {
  description = "ID da VPC criada."
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "CIDR da VPC."
  value       = aws_vpc.this.cidr_block
}

output "public_subnet_ids" {
  description = "IDs das subnets públicas."
  value       = [for az in var.azs : aws_subnet.public[az].id]
}

output "private_subnet_ids" {
  description = "IDs das subnets privadas."
  value       = [for az in var.azs : aws_subnet.private[az].id]
}

output "public_route_table_id" {
  description = "ID da route table pública."
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "ID da route table privada."
  value       = aws_route_table.private.id
}

output "nat_gateway_id" {
  description = "ID do NAT Gateway quando habilitado."
  value       = try(aws_nat_gateway.this[0].id, null)
}
