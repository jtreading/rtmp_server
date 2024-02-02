#!/bin/bash
# Update and install Nginx
sudo apt-get update
sudo apt-get install -y nginx

# Display Nginx version
sudo nginx -v

# Create nginx.conf in conf.d
echo 'worker_processes  2;
events {
	worker_connections  8192;
}
rtmp {
	server {
		listen 1935;
		chunk_size 4096;

		application live {
			live on;
			record off;

			# To push to multiple locations, uncomment lines below and substitute in your RTMP URI and stream key
			# push rtmp://server/path/streamkey;
		}
}' | sudo tee /etc/nginx/conf.d/nginx.conf

# Reload Nginx to apply changes
sudo nginx -s reload

# Display status after setup
sudo systemctl status nginx.service