resource "aws_dynamodb_table" "this" {
  attribute {
    name = "id"
    type = "N"
  }
}