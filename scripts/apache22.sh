#!/bin/bash

# Add phpinfo to web dir
echo "<?php phpinfo();"  > /var/www/phpinfo.php

sed -i "s/export APACHE_RUN_USER=www-data/export APACHE_RUN_USER=vagrant/" /etc/apache2/envvars
chown -R vagrant /var/www/
usermod -a -G www-data vagrant

a2enmod headers expires deflate rewrite

# Enable DEFLATE on application/json - this helps with Sugar metadata payloads
cat >> /etc/apache2/mods-enabled/deflate.conf <<DELIM
<IfModule mod_deflate.c>
	AddOutputFilterByType DEFLATE application/json
</IfModule>
DELIM

# Update Apache config on web server to AllowOverride
sed -i "s/AllowOverride None/AllowOverride All/" /etc/apache2/sites-enabled/000-default

# Set up port 8080 virtualhost config to allow interactive installs of Sugar
# Also make sure sugar directory has AllowOverride enabled
cat >> /etc/apache2/sites-available/sugar <<DELIM
Listen 8080
<VirtualHost *:8080>
	ServerName localhost
	DocumentRoot /var/www
</VirtualHost>
<Directory "/var/www/sugar">
	Options Indexes FollowSymLinks MultiViews
	AllowOverride All
	Order allow,deny
	Allow from all
</Directory>
DELIM
a2ensite sugar

# Restart apache22 when done
apachectl restart