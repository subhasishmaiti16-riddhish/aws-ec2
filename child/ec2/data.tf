data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_subnet" "public" {
  filter {
    name   = "tag:Name"
    values = ["dev-subnet1"]
  }
}

data "aws_subnet" "private" {
  filter {
    name   = "tag:Name"
    values = ["dev-subnet2"]
  }
}

data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["dev-vpc"]
  }
}

data "aws_security_group" "private" {
  name   = "terraform-ssh-sg"
  vpc_id = data.aws_vpc.main.id
}

data "aws_security_group" "bastion" {
  name   = "bastion-sg"
  vpc_id = data.aws_vpc.main.id
}
