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
  subnet_id                   = module.spoke1_transit1.vpc.private_subnets[0].subnet_id
  vpc_security_group_ids      = [aws_security_group.spoke1_instance_sg.id]
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.ssm_instance_profile.name

  user_data = <<EOF
#!/bin/bash
sudo sed 's/PasswordAuthentication no/PasswordAuthentication yes/' -i /etc/ssh/sshd_config
sudo systemctl restart sshd
echo ec2-user:${var.vm_admin_password} | sudo chpasswd
EOF

  tags = {
    Name = "spoke1-instance"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# spoke2 ec2
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "spoke2_instance_sg" {
  name        = "spoke2/sg-instance"
  description = "Allow all traffic from VPCs inbound and all outbound"
  vpc_id      = module.spoke2_transit1.vpc.vpc_id

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
  subnet_id                   = module.spoke2_transit1.vpc.private_subnets[0].subnet_id
  vpc_security_group_ids      = [aws_security_group.spoke2_instance_sg.id]
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.ssm_instance_profile.name

  user_data = <<EOF
#!/bin/bash
sudo sed 's/PasswordAuthentication no/PasswordAuthentication yes/' -i /etc/ssh/sshd_config
sudo systemctl restart sshd
echo ec2-user:${var.vm_admin_password} | sudo chpasswd
EOF

  tags = {
    Name = "spoke2-instance"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# spoke3 ec2
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "spoke3_instance_sg" {
  name        = "spoke3/sg-instance"
  description = "Allow all traffic from VPCs inbound and all outbound"
  vpc_id      = module.spoke3_transit2.vpc.vpc_id

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
    Name = "spoke3/sg-instance"
  }
}

resource "aws_instance" "spoke3_instance" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = module.spoke3_transit2.vpc.private_subnets[0].subnet_id
  vpc_security_group_ids      = [aws_security_group.spoke3_instance_sg.id]
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.ssm_instance_profile.name

  user_data = <<EOF
#!/bin/bash
sudo sed 's/PasswordAuthentication no/PasswordAuthentication yes/' -i /etc/ssh/sshd_config
sudo systemctl restart sshd
echo ec2-user:${var.vm_admin_password} | sudo chpasswd
EOF

  tags = {
    Name = "spoke3-instance"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# spoke4 ec2
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "spoke4_instance_sg" {
  name        = "spoke4/sg-instance"
  description = "Allow all traffic from VPCs inbound and all outbound"
  vpc_id      = module.spoke4_transit2.vpc.vpc_id

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
    Name = "spoke4/sg-instance"
  }
}

resource "aws_instance" "spoke4_instance" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = module.spoke4_transit2.vpc.private_subnets[0].subnet_id
  vpc_security_group_ids      = [aws_security_group.spoke4_instance_sg.id]
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.ssm_instance_profile.name

  user_data = <<EOF
#!/bin/bash
sudo sed 's/PasswordAuthentication no/PasswordAuthentication yes/' -i /etc/ssh/sshd_config
sudo systemctl restart sshd
echo ec2-user:${var.vm_admin_password} | sudo chpasswd
EOF

  tags = {
    Name = "spoke4-instance"
  }
}
