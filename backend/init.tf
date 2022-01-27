provider "aws" {
  region = "us-east-1"
}

# S3 bucket for backend
resource "aws_s3_bucket" "tfstate" {
  bucket = "seung-test-tfstate"

  versioning {
    enabled = true
  }
}

# DynamoDB for terraform state lock
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-lock"
  hash_key       = "LockID"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
