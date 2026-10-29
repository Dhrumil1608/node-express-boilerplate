#!/bin/bash
set -euo pipefail

cd /opt/node-express-cicd

# Stop an existing version if present.
sudo -u ubuntu -H bash -lc \
  'cd /opt/node-express-cicd && ./node_modules/.bin/pm2 delete aws-native-cicd-demo >/dev/null 2>&1 || true'

# Start the deployed app with PM2.
sudo -u ubuntu -H bash -lc \
  'cd /opt/node-express-cicd && ./node_modules/.bin/pm2 start ecosystem.config.json --update-env'

# Save the current PM2 process list.
sudo -u ubuntu -H bash -lc \
  'cd /opt/node-express-cicd && ./node_modules/.bin/pm2 save'