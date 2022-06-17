output "s_pub_id" {
  value = aws_subnet.my_subnet_public.id
}

output "sg_pub_id" {
  value = aws_security_group.my_security_group_public.id
}

output "s_pri_id" {
  value = aws_subnet.my_subnet_private.id
}

