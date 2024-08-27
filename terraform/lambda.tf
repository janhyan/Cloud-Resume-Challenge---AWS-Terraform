resource "aws_lambda_function" "this" {
  function_name = "UpdateDB"
  role          = aws_iam_role.lambda_role.arn

  runtime  = "python3.8"
  timeout  = 300
  filename = "src/update_db.zip"
  handler  = "update_db.lambda_handler"

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.this.name
    }
  }
}

resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/*"
}
