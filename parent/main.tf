
module "vpc-dev" {
  source = "../../child/vpc"
  vpc    = var.vpc-dev
}

module "subnet-dev" {
  depends_on = [module.vpc-dev]
  source     = "../../child/subnet"
  subnet     = var.subnet-dev
}

module "security_group-dev" {
  depends_on = [module.vpc-dev]
  source     = "../../child/Security_group"
  sg         = var.sg-dev
}

# IGW should depend on VPC, not Route Table
module "ig-dev" {
  depends_on = [module.vpc-dev]
  source     = "../../child/internet_gateway"
  ig         = var.ig-dev
}

module "nat-dev" {
  depends_on = [module.subnet-dev, module.ig-dev]
  source     = "../../child/nat_gw"
  nat        = var.nat-dev
}

# Route table depends on NAT and IGW
module "route-table-dev" {
  source = "../../child/route"

  route = var.route-table-dev

  igw_id = module.ig-dev.igw_id["ig-dev1"]

  nat_gateway_id = module.nat-dev.nat_gateway_id["nat-dev1"]
}
module "ec2-dev" {
  depends_on = [
    module.subnet-dev,
    module.security_group-dev,
    module.route-table-dev
  ]
  source = "../../child/ec2"
  ec2    = var.ec2-dev
}
