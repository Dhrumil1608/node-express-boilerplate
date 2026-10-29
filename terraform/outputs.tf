output "ec2_public_ip" {
  description = "Public IPv4 address of the demo instance"
  value       = aws_instance.app.public_ip
}

output "app_url" {
  description = "Demo application URL"
  value       = "http://${aws_instance.app.public_ip}:3000"
}

output "health_url" {
  description = "Demo health endpoint"
  value       = "http://${aws_instance.app.public_ip}:3000/health"
}

output "artifact_bucket" {
  description = "S3 pipeline artifact bucket"
  value       = aws_s3_bucket.artifacts.bucket
}

output "secret_arn" {
  description = "ARN of the demo secret"
  value       = aws_secretsmanager_secret.db_password.arn
}

output "github_connection_arn" {
  description = "CodePipeline GitHub connection ARN"
  value       = local.local_connection_arn
}