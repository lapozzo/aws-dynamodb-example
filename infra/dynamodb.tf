resource "aws_dynamodb_table" "investment_orders" {
  count          = var.dynamodb_enabled ? 1 : 0
  name           = "InvestmentOrders"
  billing_mode   = "PROVISIONED"
  read_capacity  = 2
  write_capacity = 2
  hash_key       = "InvestorId"
  range_key      = "OrderId"

  attribute {
    name = "InvestorId"
    type = "S"
  }

  attribute {
    name = "OrderId"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  tags  = {
    Name        = "${var.app_name}-table"
    Environment = var.app_environment
  }
}