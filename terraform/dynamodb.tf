resource "aws_dynamodb_table" "this" {
  name = "Visitor"
  attribute {
    name = "id"
    type = "N"
  }
  hash_key = "id"
  billing_mode = "PAY_PER_REQUEST"

  tags = {
    Environment = "PRODUCTION"
  }
}

resource "aws_dynamodb_table_item" "this" {
  table_name = aws_dynamodb_table.this.name
  hash_key   = aws_dynamodb_table.this.hash_key

  item = <<ITEM
{
  "id": {"N": "0"},
  "count": {"N": "0"}
}
ITEM
}