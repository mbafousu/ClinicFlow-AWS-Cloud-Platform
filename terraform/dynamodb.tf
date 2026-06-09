resource "aws_dynamodb_table" "appointments" {
  name         = "${var.project_name}-appointments"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "appointmentId"

  attribute {
    name = "appointmentId"
    type = "S"
  }
}