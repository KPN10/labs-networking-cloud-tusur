#!/bin/bash

echo "=== Install PHP modules ==="

sudo apt install php libapache2-mod-php php-mysql -y
sudo systemctl restart apache2
