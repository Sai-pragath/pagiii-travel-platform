#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "=============================================="
echo " Starting Native Apache Reverse Proxy Setup"
echo "=============================================="

# 1. Update packages and install Apache
echo "Updating packages and installing apache2..."
sudo apt update || true
sudo apt install -y apache2

# 2. Enable proxy modules
echo "Enabling proxy modules..."
sudo a2enmod proxy
sudo a2enmod proxy_http

# 3. Create the Virtual Host Configuration
echo "Creating Virtual Host config at /etc/apache2/sites-available/pagiii.conf..."
sudo tee /etc/apache2/sites-available/pagiii.conf > /dev/null <<EOF
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html

    # Proxy Configuration
    ProxyPreserveHost On
    ProxyPass / http://localhost:8080/
    ProxyPassReverse / http://localhost:8080/

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

# 4. Enable the new site and disable the default site
echo "Enabling pagiii site and disabling default site..."
sudo a2ensite pagiii.conf
sudo a2dissite 000-default.conf

# 5. Restart Apache to apply changes
echo "Restarting Apache..."
sudo systemctl restart apache2

echo "=============================================="
echo " Setup Complete! Apache is now running."
echo " Verify with: systemctl status apache2"
echo "=============================================="
