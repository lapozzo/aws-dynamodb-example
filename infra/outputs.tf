output "dynamodb_investment_orders_table" {
  description = "The DynamoDB investment_orders table"
  value       = "${aws_dynamodb_table.investment_orders[0].arn}"
}
