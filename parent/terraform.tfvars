vpc-dev = {
  dev-vpc = {
    cidr_block = "10.0.0.0/16"
  }
}
subnet-dev = {
  dev-subnet1 = {
    vpc_id            = "dev-vpc"
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-1a"

  }
  dev-subnet2 = {
    vpc_id            = "dev-vpc"
    cidr_block        = "10.0.2.0/24"
    availability_zone = "us-east-1b"
  }
  dev-subnet3 = {
    vpc_id            = "dev-vpc"
    cidr_block        = "10.0.3.0/24"
    availability_zone = "us-east-1c"
  }
}
sg-dev = {
  sg-dev1 = {
    sg_name  = "terraform-ssh-sg"
    bsg_name = "bastion-sg"
  }
}
ec2-dev = {
  ec2-dev1 = {
    sg_name               = "terraform-ssh-sg"
    instance_type_private = "t3.micro"
    key_name              = "terraform-key"
    ec2_name              = "new_ec2"
  }
  ec2-dev2 = {
    sg_name               = "bastion-sg"
    instance_type_bastion = "t3.micro"
    key_name              = "terraform-key"
    bastion_ec2_name      = "bastion-host"

  }
}
nat-dev = {
  nat-dev1 = {
    domain   = "vpc"
    eip_name = "dev-eip"
    nat_name = "dev-nat"
  }
}
ig-dev = {
  ig-dev1 = {
    ig_name = "dev-igw"
  }
}
route-table-dev = {
  route-table-dev1 = {
    public_route_table_name  = "public-route-table"
    private_route_table_name = "private-route-table"
  }
}
