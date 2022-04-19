#!/bin/bash
#
# Setup the the box. This runs as root

apt-get -y install software-properties-common python-pycurl python-apt perl curl zip vim

# add extra php repositories
add-apt-repository ppa:ondrej/php
add-apt-repository ppa:ondrej/apache2

apt-get -y update
# You can install anything you need here.

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3A79BD29

wget https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb
DEBIAN_FRONTEND=noninteractive dpkg --install mysql-apt-config_0.8.22-1_all.deb
apt-get update

sudo debconf-set-selections <<< "mysql-community-server mysql-community-server/root-pass password root";
sudo debconf-set-selections <<< "mysql-community-server mysql-community-server/re-root-pass password root"
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server

# Install Apache+php stack
apt-get -y install apache2

apt-get -y install php8.0-mysql php8.0-curl php8.0-gd php8.0-imap php8.0-mbstring php8.0-bcmath php8.0-zip php8.0-xml php8.0 php8.0-curl php8.0-dev php8.0-xdebug php8.0-mcrypt php8.0-gmp php8.0-ldap php8.0-soap

apt-get -y install php8.0-cli

apt-get -y install libapache2-mod-php8.0

# Update apache2 php.ini with appropriate Sugar values
sed -i 's/memory_limit =.*/memory_limit = 512M/' /etc/php/8.0/apache2/php.ini
sed -i 's/upload_max_filesize =.*/upload_max_filesize = 20M/' /etc/php/8.0/apache2/php.ini
sed -i 's/max_execution_time =.*/max_execution_time = 300/' /etc/php/8.0/apache2/php.ini
sed -i 's/;date.timezone =/date.timezone = UTC/' /etc/php/8.0/apache2/php.ini


# Suggested OPcache settings for Sugar
cat >> /etc/php/8.0/mods-available/opcache.ini <<DELIM
opcache.max_accelerated_files = 10000
opcache.memory_consumption = 256
opcache.fast_shutdown = 1
opcache.interned_strings_buffer = 16
DELIM


# Update cli php.ini for cron
sed -i 's/;date.timezone =/date.timezone = UTC/' /etc/php/8.0/cli/php.ini

# Update MySQL 8.0 defaults to remove ONLY_FULL_GROUP_BY option that causes problems with Sugar's Reports module
cat >> /etc/mysql/mysql.conf.d/sql_mode.cnf <<DELIM
[mysqld]
sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION
optimizer-switch=block_nested_loop=off
DELIM
