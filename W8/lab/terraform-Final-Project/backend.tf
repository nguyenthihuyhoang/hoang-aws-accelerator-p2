terraform {
  backend "s3" {
    bucket         = "tfstate-newbie" # TODO: Thay bằng bucket S3 lưu state thực tế của bạn
    key            = "final-project/terraform.tfstate"
    region         = "ap-southeast-1"
#    dynamodb_table = "terraform-state-lock"       # Bảng DynamoDB để khóa state
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}
