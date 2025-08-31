variable "ecr_name" {
  description = "Name of repository"
  type        = string
}

variable "force_delete" {
  description = "bool variable delete or no"
  type        = bool
  default     = true
}

variable "scan_on_push" {
  description = "bool variable scan or no"
  type        = bool
  default     = true
}

variable "image_tag_mutability" {
  description = "MUTABLE / IMUTABLE tag"
  type        = string
  default     = "MUTABLE"
}
