// Define lambda for my-slack_event_handler
resource "aws_lambda_function" "my-slack_event_handler" {
  function_name = var.lambda_app_name
  description   = var.lambda_app_description

  runtime = var.lambda_runtime
  handler = var.lambda_handler

  filename         = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256

  architectures = var.lambda_architecture
  memory_size   = var.lambda_memory_size
  role          = data.aws_iam_role.iam_for_lambda.arn
  tags          = var.tags

  environment {
    variables = var.lambda_env_variables
  }
}

//Provides a CloudWatch Log Group resource for the Lambda function
resource "aws_cloudwatch_log_group" "my-slack_event_handler_lambda" {
  name              = "/aws/lambda/${aws_lambda_function.my-slack_event_handler.function_name}"
  retention_in_days = var.cloudwatch_log_retention_days
  tags              = var.tags
}

//Provides a CloudWatch Log Group resource for the API Gateway
resource "aws_cloudwatch_log_group" "my-slack_event_handler_api_gw" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.my-slack_event_handler.name}"

  retention_in_days = var.cloudwatch_log_retention_days
  tags              = var.tags
}

// Attaches a Managed IAM Policy to an IAM role
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = data.aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

// Manages an Amazon API Gateway Version 2 API.
resource "aws_apigatewayv2_api" "my-slack_event_handler" {
  name          = var.lambda_app_name
  protocol_type = var.api_gw_protocol_type
  tags          = var.tags
}

// Manages an Amazon API Gateway Version 2 stage
resource "aws_apigatewayv2_stage" "my-slack_event_handler" {
  api_id = aws_apigatewayv2_api.my-slack_event_handler.id

  name        = var.lambda_app_name
  auto_deploy = true
  tags        = var.tags

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.my-slack_event_handler_lambda.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}

// Manages an Amazon API Gateway Version 2 integration
resource "aws_apigatewayv2_integration" "my-slack_event_handler" {
  api_id = aws_apigatewayv2_api.my-slack_event_handler.id

  integration_uri    = aws_lambda_function.my-slack_event_handler.invoke_arn
  integration_type   = var.api_gw_integration_type
  integration_method = var.api_gw_integration_methode
}

resource "aws_apigatewayv2_route" "my-slack_event_handler" {
  api_id = aws_apigatewayv2_api.my-slack_event_handler.id

  route_key = var.api_gw_route_key
  target    = "integrations/${aws_apigatewayv2_integration.my-slack_event_handler.id}"
}

// Gives an external source (like an EventBridge Rule, SNS, or S3) permission to access the Lambda function.
resource "aws_lambda_permission" "my-slack_event_handler" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my-slack_event_handler.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.my-slack_event_handler.execution_arn}/*/*"
}
