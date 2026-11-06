resource "tls_private_key" "ssh" {
  for_each  = var.ec2
  algorithm = each.value.key_algorithm
  rsa_bits  = each.value.key_rsa_bits
}

resource "aws_key_pair" "terraform" {
  for_each   = var.ec2
  key_name   = each.value.key_name
  public_key = tls_private_key.ssh[each.key].public_key_openssh
}


resource "aws_instance" "private" {
  for_each = {
    for key, value in var.ec2 :
    key => value if key == "ec2-dev1"
  }

  ami           = data.aws_ami.ubuntu.id
  instance_type = each.value.instance_type_private

  subnet_id = data.aws_subnet.private.id

  key_name = aws_key_pair.terraform[each.key].key_name

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

  key_name = aws_key_pair.terraform[each.key].key_name

  vpc_security_group_ids = [
    data.aws_security_group.bastion.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = each.value.bastion_ec2_name
  }
}