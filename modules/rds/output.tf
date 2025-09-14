# Unified endpoint (Aurora or RDS)
output "endpoint" {
  description = "RDS or Aurora endpoint"
  value       = var.use_aurora ? aws_rds_cluster.aurora[0].endpoint : aws_db_instance.standard[0].endpoint
}

# Port (both resources expose port)
output "port" {
  value = var.use_aurora ? aws_rds_cluster.aurora[0].port : aws_db_instance.standard[0].port
}

# Database name
output "db_name" {
  value = var.db_name
}

# Username
output "username" {
  value = var.username
}

# Password (from variable, not resource)
output "password" {
  value     = var.password
  sensitive = true
}
