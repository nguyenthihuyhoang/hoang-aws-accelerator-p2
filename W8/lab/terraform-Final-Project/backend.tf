# Terraform Backend Configuration
# Configures S3 Backend & DynamoDB for State Locking
terraform {
  # backend "s3" {
  #   bucket         = "your-terraform-state-bucket"
  #   key            = "final-project/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "your-terraform-state-lock"
  #   encrypt        = true
  # }
}
