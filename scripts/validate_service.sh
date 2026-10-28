#!/bin/bash
set -euo pipefail

for attempt in $(seq 1 20); do
  if curl --fail --silent \
    http://127.0.0.1:3000/health \
    >/tmp/cicd-health.json; then

    cat /tmp/cicd-health.json
    exit 0
  fi

  sleep 3
done

echo "Health check failed" >&2
exit 1