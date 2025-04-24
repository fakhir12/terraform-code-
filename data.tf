data "aws_ssm_parameter" "ubuntu_latest_ami" {
  name = "/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

# resource "aws_instance" "LT" {
#   ami                    = data.aws_ssm_parameter.ubuntu_latest_ami.value
#   # instance_type          = "t2.micro"
#   subnet_id              = module.vpc.public_subnet_ids[0]
#   vpc_security_group_ids = module.security.ec2_allow_http_ssh_sg_id[0]
# }



data "aws_availability_zones" "available" {
  state = "available"
}