output "database_url" {
  value = "postgres://${var.db_user}:${var.db_password}@${aws_db_instance.postgres.address}:${aws_db_instance.postgres.port}/${var.db_name}"
  description = "Connection string for the PostgreSQL database"
  sensitive = true
}
