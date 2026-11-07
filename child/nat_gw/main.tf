resource "aws_eip" "nat" {
  for_each = var.nat
  domain   = each.value.domain

  tags = {
    Name = each.value.eip_name
  }
}

resource "aws_nat_gateway" "main" {
  for_each      = var.nat
  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = data.aws_subnet.public.id

  tags = {
    Name = each.value.nat_name
  }

  # depends_on = [
  #   aws_internet_gateway.main ### eita banate hobe
  # ]
}
