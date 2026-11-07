
resource "aws_route_table" "public" {
  for_each = var.route
  vpc_id   = data.aws_vpc.main.id

  tags = {
    Name = each.value.public_route_table_name
  }
}

resource "aws_route_table" "private" {
  for_each = var.route
  vpc_id   = data.aws_vpc.main.id

  tags = {
    Name = each.value.private_route_table_name
  }
}

resource "aws_route" "public_internet" {
  for_each = var.route

  route_table_id         = aws_route_table.public[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}

resource "aws_route" "private_nat" {
  for_each = var.route

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_gateway_id
}
resource "aws_route_table_association" "public" {
  subnet_id      = "subnet-04787196016ffe02f"   # বা data source/variable থেকে
  route_table_id = aws_route_table.public["route-table-dev1"].id
}
