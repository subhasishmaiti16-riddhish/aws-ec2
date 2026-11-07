output "nat_gateway_id" {
  value = {
    for key, nat in aws_nat_gateway.main :
    key => nat.id
  }
}