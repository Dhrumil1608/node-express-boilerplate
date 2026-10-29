resource "aws_secretsmanager_secret" "db_password" {
  name        = "node-express-cicd/db-password"
  description = "Dummy DB_PASSWORD for the CI/CD learning project"

  recovery_window_in_days = 7
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id = aws_secretsmanager_secret.db_password.id

  secret_string = jsonencode({
    DB_PASSWORD = var.db_password_dummy
  })
}