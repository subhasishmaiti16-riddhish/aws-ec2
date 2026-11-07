resource "aws_vpc" "main" {
  for_each         = var.vpc
  cidr_block       = each.value.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = each.key
  }
}
