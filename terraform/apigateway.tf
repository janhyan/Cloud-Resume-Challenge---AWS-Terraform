resource "aws_api_gateway_rest_api" "this" {
    name = "update-db-api"
    description = "API for Lambda Function to update DynamoDB"
    endpoint_configuration {
        types = ["REGIONAL"]
    }
}

# resource "aws_api_gateway_resource" "this" {
#     rest_api_id = aws_api_gateway_rest_api.this.id
#     parent_id = aws_api_gateway_rest_api.this.root_resource_id
#     path_part = "get"
# }

resource "aws_api_gateway_method" "this" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_rest_api.this.root_resource_id
    http_method = "GET"
    authorization = "NONE"
}

resource "aws_api_gateway_method_response" "this" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_rest_api.this.root_resource_id
    http_method = aws_api_gateway_method.this.http_method
    status_code = "200"
}

resource "aws_api_gateway_integration" "this" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_rest_api.this.root_resource_id
    http_method = aws_api_gateway_method.this.http_method
    integration_http_method = "POST"
    type = "AWS_PROXY"
    uri = aws_lambda_function.this.invoke_arn
}

resource "aws_api_gateway_deployment" "this" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    stage_name = "dev"
    depends_on = [
        aws_api_gateway_integration.this
    ]
}