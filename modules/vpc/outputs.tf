output "vpc_id" {
  description = "ID da VPC criada."
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "CIDR da VPC."
  value       = aws_vpc.this.cidr_block
}

output "public_subnet_ids" {
  description = "IDs das subnets publicas."
  value       = [for subnet in values(aws_subnet.public) : subnet.id]
}

output "private_subnet_ids" {
  description = "IDs das subnets privadas."
  value       = [for subnet in values(aws_subnet.private) : subnet.id]
}

output "public_route_table_id" {
  description = "ID da route table publica."
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
