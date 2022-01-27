terraform {
    backend "s3" {
      bucket         = "seung-test-tfstate" # s3 bucket 이름
      key            = "terraform/backend/terraform.tfstate" # s3 내에서 저장되는 경로를 의미합니다            region         = "us-east-1"  
      encrypt        = true
      dynamodb_table = "terraform-lock"
    }
}
