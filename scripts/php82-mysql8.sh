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

wget https://dev.mysql.com/get/mysql-apt-config_0.8.24-1_all.deb
DEBIAN_FRONTEND=noninteractive dpkg --install mysql-apt-config_0.8.24-1_all.deb
apt-get update

sudo debconf-set-selections <<< "mysql-community-server mysql-community-server/root-pass password root";
sudo debconf-set-selections <<< "mysql-community-server mysql-community-server/re-root-pass password root"
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server

# Install Apache+php stack
apt-get -y install apache2

apt-get -y install php8.2-mysql php8.2-curl php8.2-gd php8.2-imap php8.2-mbstring php8.2-bcmath php8.2-zip php8.2-xml php8.2 php8.2-curl php8.2-dev php8.2-xdebug php8.2-mcrypt php8.2-gmp php8.2-ldap php8.2-soap

apt-get -y install php8.2-cli

apt-get -y install libapache2-mod-php8.2

# Update apache2 php.ini with appropriate Sugar values
sed -i 's/memory_limit =.*/memory_limit = 512M/' /etc/php/8.2/apache2/php.ini
sed -i 's/upload_max_filesize =.*/upload_max_filesize = 20M/' /etc/php/8.2/apache2/php.ini
sed -i 's/max_execution_time =.*/max_execution_time = 300/' /etc/php/8.2/apache2/php.ini
sed -i 's/;date.timezone =/date.timezone = UTC/' /etc/php/8.2/apache2/php.ini


# Suggested OPcache settings for Sugar
cat >> /etc/php/8.2/mods-available/opcache.ini <<DELIM
opcache.max_accelerated_files = 10000
opcache.memory_consumption = 256
opcache.fast_shutdown = 1
opcache.interned_strings_buffer = 16
DELIM


# Update cli php.ini for cron
sed -i 's/;date.timezone =/date.timezone = UTC/' /etc/php/8.2/cli/php.ini

# Update MySQL 8.2 defaults to remove ONLY_FULL_GROUP_BY option that causes problems with Sugar's Reports module
cat >> /etc/mysql/mysql.conf.d/sql_mode.cnf <<DELIM
[mysqld]
sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION
optimizer-switch=block_nested_loop=off
DELIM
