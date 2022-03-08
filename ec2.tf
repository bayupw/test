# ---------------------------------------------------------------------------------------------------------------------
# spoke1 ec2
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "spoke1_instance_sg" {
  name        = "spoke1/sg-instance"
  description = "Allow all traffic from VPCs inbound and all outbound"
  vpc_id      = module.spoke1_transit1.vpc.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = local.ingress_cidr_blocks
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "spoke1/sg-instance"
  }
}

resource "aws_instance" "spoke1_instance" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = module.spoke1_transit1.vpc.public_subnets[0].subnet_id
  vpc_security_group_ids      = [aws_security_group.spoke1_instance_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "spoke1-instance"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# spoke2 ec2
# ---------------------------------------------------------------------------------------------------------------------

/* resource "aws_security_group" "spoke2_instance_sg" {
  name        = "spoke2/sg-instance"
  description = "Allow all traffic from VPCs inbound and all outbound"
  vpc_id      = module.spoke1_transit1.vpc.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = local.ingress_cidr_blocks
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "spoke2/sg-instance"
  }
}

resource "aws_instance" "spoke2_instance" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = module.spoke2_transit1.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.spoke2_instance_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "spoke2-instance"
  }
}
 */