provider "aws" {
  region     = var.aws_region
  # access_key = var.aws_access_key
  # secret_key = var.aws_secret_key
}

resource "aws_iam_role_policy" "dynamo_lambda_policy" {
  name = "dynamo_lambda_policy"
  role = aws_iam_role.iam_for_lambda.id

  policy = jsonencode({  
  "Version": "2012-10-17",
  "Statement":[{
    "Effect": "Allow",
    "Action": [
     "dynamodb:BatchGetItem",
     "dynamodb:GetItem",
     "dynamodb:Query",
     "dynamodb:Scan",
     "dynamodb:BatchWriteItem",
     "dynamodb:PutItem",
     "dynamodb:UpdateItem"
    ],
    "Resource": "${var.dynamodb_investor_order_table_arn}"
   }
  ]
})
}
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "cloudwatch_lambda_policy" {
  name = "cloudwatch_lambda_policy"
  role = aws_iam_role.iam_for_lambda.id

  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
})
}

resource "aws_cloudwatch_log_group" "example" {
  name              = "/aws/lambda/orders_loader"
  retention_in_days = 7
}

resource "aws_lambda_function" "orders_loader" {
  function_name    = "orders_loader"
  filename         = "../app.zip"
  handler          = "app.lambda_handler"
  role             = aws_iam_role.iam_for_lambda.arn
  source_code_hash = filebase64sha256("../app.zip")
  runtime          = "python3.8"
  timeout          = 5
  memory_size      = 128
  environment {
    variables = {
      ORDERS_TABLE = "${var.dynamodb_investor_order_table_name}"
    }
  }

  tags  = {
    Name        = "${var.app_name}-lambda"
    Environment = var.app_environment
  }
}
