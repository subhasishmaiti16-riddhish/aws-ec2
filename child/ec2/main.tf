resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "terraform" {
  key_name   = "terraform-key"
  public_key = tls_private_key.ssh.public_key_openssh
}


resource "aws_instance" "private" {
  for_each = {
    for key, value in var.ec2 :
    key => value if key == "ec2-dev1"
  }

  ami           = data.aws_ami.ubuntu.id
  instance_type = each.value.instance_type_private

  subnet_id = data.aws_subnet.private.id

  key_name = aws_key_pair.terraform.key_name

  vpc_security_group_ids = [
    data.aws_security_group.private.id
  ]

  associate_public_ip_address = false

  tags = {
    Name = each.value.ec2_name
  }
}

resource "aws_instance" "bastion" {
  for_each = {
    for key, value in var.ec2 :
    key => value if key == "ec2-dev2"
  }

  ami           = data.aws_ami.ubuntu.id
  instance_type = each.value.instance_type_bastion

  subnet_id = data.aws_subnet.public.id

  key_name = aws_key_pair.terraform.key_name

  vpc_security_group_ids = [
    data.aws_security_group.bastion.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = each.value.bastion_ec2_name
  }
}

moved {
  from = aws_instance.ec2["ec2-dev1"]
  to   = aws_instance.private["ec2-dev1"]
}

moved {
  from = tls_private_key.ssh["ec2-dev1"]
  to   = tls_private_key.ssh
}

moved {
  from = aws_key_pair.terraform["ec2-dev1"]
  to   = aws_key_pair.terraform
}