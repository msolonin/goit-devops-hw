variable "db_name" {
    description = "Name of the EKS cluster"
    type        = string
    default     = "lesson7db" 
}

variable "db_user" {
    description = "Name of the EKS cluster"
    type        = string
    default = "lesson7user"
}

variable "db_password" { 
    description = "Name of the EKS cluster"
    type        = string
    default = "admin123" 
    }
