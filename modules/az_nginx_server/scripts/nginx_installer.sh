#!/bin/bash

sudo apt update
echo "[INFO] Intalling nginx"
sudo apt install -y nginx vim curl
echo "[INFO] Creating index file for nginx"
sudo rm -rf /var/www/html/index.nginx-debian.html
sudo touch /var/www/html/index.html
cat > /var/www/html/index.html << EOF
    <h1>Hello from NGINX server</h1>
EOF
echo "[INFO] Restarting nginx service"
sudo systemctl restart nginx
