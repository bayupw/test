module "vpcs" {
  for_each        = var.vpcs
  source          = "terraform-aws-modules/vpc/aws"
  version         = "~> 3.0"
  name            = each.value.name
  cidr            = each.value.cidr
  azs             = ["${data.aws_region.current.name}a"]
  private_subnets = each.value.private_subnets
  enable_ipv6     = false
}

resource "aws_security_group" "security_groups" {
  for_each    = module.vpcs
  name        = each.key
  description = "Allow any"
  vpc_id      = each.value.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${each.key}"
  }

  lifecycle {
    ignore_changes = [ingress, egress]
  }
}