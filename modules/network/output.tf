output "subnet_id_1" {
  value = aws_subnet.dawid-terra-1.id
}

output "subnet_id_2" {
  value = one(aws_subnet.dawid-terra-2[*].id)
}

output "vpc_id" {
  value = aws_vpc.dawid-terra.id
}
