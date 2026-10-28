
#!/bin/bash
set -euo pipefail

APP_DIR="/opt/node-express-cicd"
SERVICE_NAME="aws-native-cicd-demo"

# Create a systemd service for the Node.js application.
cat > "/etc/systemd/system/${SERVICE_NAME}.service" <<EOF
[Unit]
Description=AWS Native CI/CD Demo Node.js Application
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=${APP_DIR}
Environment=NODE_ENV=production
Environment=PORT=3000
ExecStart=/usr/bin/node ${APP_DIR}/demo-server.js
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable "${SERVICE_NAME}"
systemctl restart "${SERVICE_NAME}"

echo "Application service started successfully."
