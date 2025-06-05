output "ecs_ami_id" {
  value = data.aws_ami.ecs.id
}

output "ecs_instance_profile_name" {
  value = aws_iam_instance_profile.ecs_instance_profile.name
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.wordpress.name
}
