#!/bin/bash
apt-get update
apt-get install -y apache2
service apache2 restart
mkdir -p /var/www/html
gsutil -m cp -r gs://${web_bucket}/* /var/www/html/