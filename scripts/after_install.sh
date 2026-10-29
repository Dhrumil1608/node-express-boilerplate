#!/bin/bash
set -euo pipefail

source /etc/node-express-cicd.env
cd /opt/node-express-cicd

# Retrieve the dummy secret using the EC2 instance profile.
SECRET_JSON="$(aws secretsmanager get-secret-value 
  --secret-id "${DB_PASSWORD_SECRET_ARN}" 
  --region "${AWS_REGION}" 
  --query SecretString 
  --output text)"

# Extract the password without printing it.
DB_PASSWORD="$(node -e '
  const s = JSON.parse(process.argv[1]);
  if (!s.DB_PASSWORD) process.exit(2);
  process.stdout.write(s.DB_PASSWORD);
' "$SECRET_JSON")"

unset SECRET_JSON

# Create a private .env file on EC2.
umask 077

printf 'PORT=3000\nNODE_ENV=production\nDB_PASSWORD=%s\n' 
  "$DB_PASSWORD" > .env

unset DB_PASSWORD

# Install runtime dependencies before assigning ownership.
npm install --omit=dev --ignore-scripts

# Ensure the application user can access all deployed files.
chown -R ubuntu:ubuntu /opt/node-express-cicd

# Keep the environment file private.
chmod 600 /opt/node-express-cicd/.env