output "aws_lambda_function" {
  description = "The arn of the Lambda"
  value       = "${aws_lambda_function.orders_loader.arn}"
}
