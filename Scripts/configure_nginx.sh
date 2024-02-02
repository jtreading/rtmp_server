#!/bin/bash
# Update and install Nginx
sudo apt-get update
sudo apt-get install -y nginx
sudo apt-get install -y libnginx-mod-rtmp

# Display Nginx version
sudo nginx -v

# Create rtmp configuration file
echo 'load_module modules/ngx_rtmp_module.so;
  worker_processes  2;
  events {
    worker_connections  8192;
  }
  rtmp {
    server {
      listen 1935;
      chunk_size 4096;
      allow publish 127.0.0.1;
      allow publish ${IngressIP};
      deny publish all;
      application live {
              live on;
              record off;
      }
    }
  }' | sudo tee /etc/nginx/nginx.conf

# Reload Nginx to apply changes
sudo nginx -s reload

# Display status after setup
sudo systemctl status nginx.service