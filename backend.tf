terraform {
  backend "s3" {
    bucket         = "devops-tfstate-msolonin"
    key            = "lesson-5/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
