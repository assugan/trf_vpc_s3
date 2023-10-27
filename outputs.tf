
output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet[*].id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.vpc_gw.id
}

output "route_table_id" {
  value = aws_route_table.vpc_route_table.id
}

output "private_security_group_id" {
  value = aws_security_group.private_sg.id
}

output "public_security_group_id" {
  value = aws_security_group.public_sg.id
}

output "public_instance_ids" {
  value = aws_instance.public_instance[*].id
}

output "private_instance_ids" {
  value = aws_instance.private_instance[*].id
}
