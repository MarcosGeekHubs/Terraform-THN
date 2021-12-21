provider "aws" {
  profile = "sandbox"
  region  = "eu-west-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "thn-marcos-bucket-s3"
  lifecycle {
    prevent_destroy = true
  }
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_locks" {
  name = "thn-marcos-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name ="LockID"
    type = "S"
  }
}

/*
terraform {
    backend "s3" {
        profile="sandbox"
        bucket= "thn-marcos-bucket-s3"
        key = "servidor/PRE/terraform.tfstate"
        region="eu-west-1"
        dynamodb_table= "thn-marcos-lock"
        encrypt = true
    }

}
*/