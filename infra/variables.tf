variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "app_name" {
  type        = string
  description = "Application Name"
}

variable "app_environment" {
  type        = string
  description = "Application Environment"
}

variable "dynamodb_enabled" {
  type        = bool
  default     = false
  description = "Enable DynamoDB Tables"
}
