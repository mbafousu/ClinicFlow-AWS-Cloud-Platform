data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "../lambda/app.py"
  output_path = "../lambda/app.zip"
}

resource "aws_lambda_function" "appointment_api" {
  function_name = "${var.project_name}-appointment-api"
  role          = aws_iam_role.lambda_role.arn
  handler       = "app.lambda_handler"
  runtime       = "python3.12"

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.appointments.name
    }
  }
}