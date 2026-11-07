resource "aws_internet_gateway" "main" {
  for_each = var.ig
  vpc_id   = data.aws_vpc.main.id

  tags = {
    Name = each.value.ig_name
  }
}
