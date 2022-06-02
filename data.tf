// Querry for the lamda role arn
/* data "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"
} */

// Compress the python lambda into a zip
data "archive_file" "zip" {
  type        = "zip"
  source_file = "${path.cwd}/${var.lambda_filename}"
  output_path = "${path.cwd}/${var.lambda_filename}.zip"
}
