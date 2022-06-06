// Define lambda for my-slack_event_handler
resource "aws_lambda_function" "lambda_function" {
  function_name = var.lambda_app_name
  description   = var.lambda_app_description

  runtime = var.lambda_runtime
  handler = var.lambda_handler

  filename         = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256

  architectures = var.lambda_architecture
  memory_size   = var.lambda_memory_size
  role          = aws_iam_role.lambda_function_execution_role.arn
  tags          = var.tags

  environment {
    variables = var.lambda_env_variables
  }
}

//Provides a CloudWatch Log Group resource for the Lambda function
resource "aws_cloudwatch_log_group" "cloudwatch_log_group_lambda_function" {
  count             = (var.lambda_cloudwatch ? 1 : 0)
  name              = "/aws/lambda/${aws_lambda_function.lambda_function.function_name}"
  retention_in_days = var.cloudwatch_log_retention_days
  tags              = var.tags
}

//Provides a CloudWatch Log Group resource for the API Gateway
resource "aws_cloudwatch_log_group" "cloudwatch_log_group_api_gateway" {
  #count = (length(aws_apigatewayv2_api.api_gateway) == 1 && var.api_gateway_cloudwatch ? 1 : 0)
  count = (length(aws_apigatewayv2_api.api_gateway) == 1 ? 1 : 0)
  name  = "/aws/api_gw/${aws_apigatewayv2_api.api_gateway[0].name}"

  retention_in_days = var.cloudwatch_log_retention_days
  tags              = var.tags
}

//Create lambda execution role
resource "aws_iam_role" "lambda_function_execution_role" {
  //name = "iam_for_lambda"
  name = var.lambda_execution_role_name

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

// Attaches a Managed IAM Policy to an IAM role
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_function_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

// Manages an Amazon API Gateway Version 2 API.
resource "aws_apigatewayv2_api" "api_gateway" {
  count         = (var.api_gateway ? 1 : 0)
  name          = var.lambda_app_name
  protocol_type = var.api_gw_protocol_type
  tags          = var.tags
}

// Manages an Amazon API Gateway Version 2 stage
resource "aws_apigatewayv2_stage" "api_gateway_stage" {
  count  = (length(aws_apigatewayv2_api.api_gateway) == 1 ? 1 : 0)
  api_id = aws_apigatewayv2_api.api_gateway[0].id

  name        = var.lambda_app_name
  auto_deploy = true
  tags        = var.tags

  /* dynamic "access_log_settings" {
    for_each = aws_cloudwatch_log_group.cloudwatch_log_group_api_gateway
    content {
        #destination_arn = aws_cloudwatch_log_group.cloudwatch_log_group_api_gateway[0].arn
        destination_arn = aws_cloudwatch_log_group.cloudwatch_log_group_api_gateway[0].arn

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
  } */

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.cloudwatch_log_group_api_gateway[0].arn

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
resource "aws_apigatewayv2_integration" "api_gateway_integration" {
  count  = (length(aws_apigatewayv2_api.api_gateway) == 1 ? 1 : 0)
  api_id = aws_apigatewayv2_api.api_gateway[0].id

  integration_uri    = aws_lambda_function.lambda_function.invoke_arn
  integration_type   = var.api_gw_integration_type
  integration_method = var.api_gw_integration_methode
}

resource "aws_apigatewayv2_route" "api_gateway_route" {
  count  = (length(aws_apigatewayv2_api.api_gateway) == 1 ? 1 : 0)
  api_id = aws_apigatewayv2_api.api_gateway[0].id

  route_key = var.api_gw_route_key
  target    = "integrations/${aws_apigatewayv2_integration.api_gateway_integration[0].id}"
}

// Gives an external source (like an EventBridge Rule, SNS, or S3) permission to access the Lambda function.
//resource "aws_lambda_permission" "my-slack_event_handler" {
resource "aws_lambda_permission" "api_gateway_lambda_permission" {
  count         = (length(aws_apigatewayv2_api.api_gateway) == 1 ? 1 : 0)
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.api_gateway[0].execution_arn}/*/*"
}
