# Static Site Server

Project: https://roadmap.sh/projects/static-site-server

## Description
Setting up a web server using Nginx to serve a static site, and using rsync 
to deploy changes from a local machine to the remote server.

## Requirements
- Remote Linux server (GCP e2-micro, Ubuntu 22.04 LTS)
- SSH access configured (see previous project)

## Steps

### 1. Install Nginx
```bash
sudo apt update
sudo apt install nginx -y
sudo systemctl status nginx
```

### 2. Configure permissions
Give the user write access to the web directory:
```bash
sudo chown -R cle-principale:cle-principale /var/www/html/
```

### 3. Create the static site locally
Created three files on the local machine:
- `index.html` — main page
- `style.css` — styles
- `image.jpg` — image

### 4. Install rsync
On the server:
```bash
sudo apt install rsync -y
```

### 5. Deploy with rsync
```bash
rsync -avz -e "ssh -i ~/.ssh/gcp_key_1" ~/my-static-site/ user@<SERVER_IP>:/var/www/html/
```

rsync only transfers modified files, making deployments fast and efficient.

### 6. Automate deployment with deploy.sh
Created a `deploy.sh` script to avoid retyping the rsync command manually:

```bash
#!/bin/bash

SERVER="user@<SERVER_IP>"
KEY="~/.ssh/gcp_key_1"
REMOTE_DIR="/var/www/html/"
LOCAL_DIR="$(dirname "$0")/"

echo "🚀 Deploying to $SERVER..."
rsync -avz -e "ssh -i $KEY" "$LOCAL_DIR" "$SERVER:$REMOTE_DIR"
echo "✅ Done!"
```

Make it executable:
```bash
chmod +x deploy.sh
```

Then deploy with:
```bash
./deploy.sh
```

## Key Learnings
- How Nginx serves static files
- How rsync works and why it's better than scp for deployments
- How to automate deployments with a shell script
- The concept behind CI/CD pipelines — deploy.sh is a manual mini-pipeline
- File permissions on Linux (chown)
