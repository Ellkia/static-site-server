#!/bin/bash

SERVER="cle-principale@34.140.197.166"
KEY="~/.ssh/gcp_key_1"
REMOTE_DIR="/var/www/html/"
LOCAL_DIR="$(dirname "$0")/"

echo "🚀 Deploying to $SERVER..."
rsync -avz -e "ssh -i $KEY" "$LOCAL_DIR" "$SERVER:$REMOTE_DIR"
echo "✅ Done!"
