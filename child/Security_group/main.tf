###### Security Group for SSH access

resource "aws_security_group" "private_ec2_sg" {
  for_each = var.sg
  name     = each.value.sg_name
  vpc_id   = data.aws_vpc.main.id

  ingress {  #####Inbound traffic rules
    description     = "SSH from Bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg[each.key].id]  #### Allow SSH access from Bastion Host Security Group
  }

  egress {  #####Outbound traffic rules
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = each.value.sg_name
  }
}


####For Bastion Host Security Group

resource "aws_security_group" "bastion_sg" {
  for_each = var.sg
  name     = each.value.bsg_name
  vpc_id   = data.aws_vpc.main.id

  ingress {   #####Inbound traffic rules
    description = "SSH from Admin IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["106.202.36.233/32"]  #### My computer's public IP address
  }

  egress {  #####Outbound traffic rules
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = each.value.bsg_name
  }
}
moved {
  from = aws_security_group.ssh["sg-dev1"]
  to   = aws_security_group.private_ec2_sg["sg-dev1"]
}