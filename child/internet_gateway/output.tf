output "igw_id" {
  value = {
    for key, value in aws_internet_gateway.main :
    key => value.id
  }
}