#!/bin/bash
set -euo pipefail

APP_DIR="/opt/node-express-cicd"
SERVICE_NAME="aws-native-cicd-demo"

cd "$APP_DIR"

# Stop and disable the previous systemd application.
if systemctl is-active --quiet "${SERVICE_NAME}.service"; then
    systemctl stop "${SERVICE_NAME}.service"
fi

systemctl disable "${SERVICE_NAME}.service" 2>/dev/null || true

# Install PM2 if missing.
if ! command -v pm2 >/dev/null 2>&1; then
    npm install -g pm2
fi

# Configure PM2 startup only if not already enabled.
if ! systemctl is-enabled --quiet pm2-ubuntu; then
    env PATH="$PATH" pm2 startup systemd -u ubuntu --hp /home/ubuntu
fi

# Start or reload the application as ubuntu.
sudo -u ubuntu -H bash -lc \
    "cd ${APP_DIR} && pm2 startOrReload ecosystem.config.json --update-env"

# Save the process list.
sudo -u ubuntu -H pm2 save

echo "Application started successfully using PM2."
