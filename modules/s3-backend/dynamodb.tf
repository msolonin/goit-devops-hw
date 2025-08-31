# # Створюємо DynamoDB-таблицю для блокування стейтів
# resource "aws_dynamodb_table" "terraform_locks" {
#   name         = var.bucket_name
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }

#   tags = {
#     Name        = "Terraform Lock Table"
#     Environment = var.env_name
#   }
# }