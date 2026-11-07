data "aws_subnet" "public" {
  filter {
    name   = "tag:Name"
    values = ["dev-subnet3"]
  }
}
