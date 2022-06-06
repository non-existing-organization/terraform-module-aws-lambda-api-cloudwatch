
variable "aws_region" {
  type        = string
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "lambda_app_name" {
  type        = string
  description = "The name of the Lambda function."
}

variable "lambda_app_description" {
  type        = string
  default     = "A simple Lambda function that says hello."
  description = "The description of the Lambda function."
}

variable "lambda_runtime" {
  type        = string
  default     = "python3.9"
  description = "The runtime to use for the Lambda function."
}

variable "lambda_handler" {
  type        = string
  description = "The name of the Lambda function's handler."
}

variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the bucket."
  default     = {}
}

variable "lambda_memory_size" {
  type        = number
  default     = 128
  description = "The amount of memory to allocate to the lambda function "
}

variable "lambda_architecture" {
  type        = list(any)
  default     = ["x86_64"]
  description = "The architecture of the lambda function "
}

variable "lambda_env_variables" {
  type        = map(string)
  description = "The environment variables to pass to the Lambda function."
  sensitive   = true
  default = {
    "variable_name" = "variable_value"
  }
}

variable "cloudwatch_log_retention_days" {
  type        = number
  default     = 14
  description = "The number of days to retain logs in CloudWatch."
}

variable "api_gw_protocol_type" {
  type        = string
  default     = "HTTP"
  description = "The protocol type for the API Gateway."
}

variable "api_gw_integration_type" {
  type        = string
  default     = "AWS_PROXY"
  description = "The integration type for the API Gateway."
}

variable "api_gw_integration_methode" {
  type        = string
  default     = "POST"
  description = "The integration methode for the API Gateway."
}

variable "api_gw_route_key" {
  type        = string
  default     = "$default"
  description = "The route key for the route. For HTTP APIs, the route key can be either `$default`, or a combination of an HTTP method and resource path, for example, `GET /pets`."
}

variable "lambda_filename" {
  type        = string
  description = "The name of the Lambda function's file."
}

variable "lambda_execution_role_name" {
  type        = string
  description = "The name of the aws lambda execution role"
  default     = "iam_for_lambda"
}

# Variables to deploy specific set of resources
variable "api_gateway" {
  type    = bool
  default = false
}

variable "lambda_cloudwatch" {
  type    = bool
  default = false
}

/* variable "api_gateway_cloudwatch" {
  type    = bool
  default = false
} */