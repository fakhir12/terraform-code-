

output "alb_sg_id"{
    value = aws_security_group.alb_sg.id

}

output "db_sg_id" {
  value = aws_security_group.db_sg.id
}

output "wordpress_sg_id" {
  value = aws_security_group.wordpress_sg.id
}