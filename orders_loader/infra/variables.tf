variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "dynamodb_investor_order_table_arn"{
  type        = string
  description = "DynamoDB table ARN"
}
variable "dynamodb_investor_order_table_name"{
  type        = string
  description = "DynamoDB table Name"
}

variable "app_name" {
  type        = string
  description = "Application Name"
}

variable "app_environment" {
  type        = string
  description = "Application Environment"
}