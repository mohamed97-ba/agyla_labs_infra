resource "aws_s3_bucket" "cuddle_serverless_bucket" {
  bucket = "med-serverless-petcuddleotron"
  force_destroy = true
}
resource "aws_s3_bucket_website_configuration" "cuddle_serverless" {
  bucket = aws_s3_bucket.cuddle_serverless_bucket.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}
resource "aws_s3_bucket_policy" "cuddle_serverless" {
  bucket = aws_s3_bucket.cuddle_serverless_bucket.id
  policy = data.aws_iam_policy_document.allow_public_access.json
  depends_on = [data.aws_iam_policy_document.allow_public_access,
                aws_s3_bucket_acl.cuddle_serverless,
   ]

}
resource "aws_s3_bucket_ownership_controls" "cuddle_serverless" {
  bucket = aws_s3_bucket.cuddle_serverless_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_acl" "cuddle_serverless" {
  depends_on = [
    aws_s3_bucket_public_access_block.cuddle_serverless,
    aws_s3_bucket_ownership_controls.cuddle_serverless,
  ]

  bucket = aws_s3_bucket.cuddle_serverless_bucket.id
  acl    = "public-read"
}
resource "aws_s3_bucket_public_access_block" "cuddle_serverless" {
  bucket = aws_s3_bucket.cuddle_serverless_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Reads the file at the given path and renders its content as a template using a supplied set of template variables
locals {
    serverless_content = templatefile("serverless_frontend/serverless_template.js", {
    API_GATEWAY_INVOKE_URL = "${var.api_gateway_invoke_url}"
  })
}

resource "null_resource" "generate_serverless" {
  provisioner "local-exec" {
    command = "echo '${local.serverless_content}' > serverless_frontend/serverless.js"
  }
  triggers = {
    serverless_content = local.serverless_content
  }
}
# Reads a file from the local filesystem.
data "local_file" "cuddle_serverless" {
  filename = "serverless_frontend/serverless.js"
  depends_on = [null_resource.generate_serverless]
}

resource "aws_s3_object" "cuddle_serverless_index" {
  bucket = aws_s3_bucket.cuddle_serverless_bucket.id
  key    = "index.html"
  source = "serverless_frontend/index.html"
  etag = filemd5("serverless_frontend/index.html")
  acl     = "public-read"
  content_type = "text/html"
  force_destroy = true
  depends_on = [
    aws_s3_bucket_acl.cuddle_serverless
  ]
}
resource "aws_s3_object" "cuddle_serverless_js" {
  bucket = aws_s3_bucket.cuddle_serverless_bucket.id
  key    = "serverless.js"
  source = "serverless_frontend/serverless.js"
  etag = md5(data.local_file.cuddle_serverless.content)
  acl     = "public-read"
  content_type = "application/javascript"
  force_destroy = true
  depends_on = [
    null_resource.generate_serverless,
    aws_s3_bucket_acl.cuddle_serverless,
    data.local_file.cuddle_serverless
  ]
}
resource "aws_s3_object" "cuddle_serverless_main" {
  bucket = aws_s3_bucket.cuddle_serverless_bucket.id
  key    = "main.css"
  source = "serverless_frontend/main.css"
  etag = filemd5("serverless_frontend/main.css")
  acl     = "public-read"
  content_type = "application/css"
  force_destroy = true
  depends_on = [
    aws_s3_bucket_acl.cuddle_serverless
  ]
}
resource "aws_s3_object" "cuddle_serverless_whiskers" {
  bucket = aws_s3_bucket.cuddle_serverless_bucket.id
  key    = "whiskers.png"
  source = "serverless_frontend/whiskers.png"
  etag = filemd5("serverless_frontend/whiskers.png")
  acl     = "public-read"
  content_type = "image/png"
  force_destroy = true
  depends_on = [
    aws_s3_bucket_acl.cuddle_serverless
  ]
}