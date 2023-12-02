data "archive_file" "lambda_demo" {
  type = "zip"

  source_dir  = "${path.module}/demo"
  output_path = "${path.module}/demo/hello.zip"
}