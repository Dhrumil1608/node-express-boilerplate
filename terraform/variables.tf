variable "aws_region" {
  description = "AWS deployment region"
  type        = string
  default     = "ap-south-1"
}

variable "github_owner" {
  description = "GitHub account owning the fork"
  type        = string
  default     = "Dhrumil1608"
}

variable "github_repo" {
  description = "Forked repository name"
  type        = string
  default     = "node-express-boilerplate"
}

variable "github_branch" {
  description = "Branch CodePipeline watches"
  type        = string
  default     = "main"
}

variable "github_connection_arn" {
  description = "Optional existing ACTIVE GitHub connection ARN"
  type        = string
  default     = ""
}

variable "allowed_ssh_cidr" {
  description = "Your public IPv4 address followed by /32"
  type        = string
}

variable "allowed_app_cidr" {
  description = "CIDR allowed to access port 3000"
  type        = string
  default     = "0.0.0.0/0"
}

variable "db_password_dummy" {
  description = "Dummy secret for this learning project only"
  type        = string
  sensitive   = true
  default     = "DemoOnly-ChangeMe-2026"
}