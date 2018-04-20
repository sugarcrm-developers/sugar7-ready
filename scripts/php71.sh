#!/bin/bash
#
# Setup the the box. This runs as root

apt-get -y install software-properties-common python-software-properties perl curl zip vim

# add extra php repositories
add-apt-repository ppa:ondrej/php

apt-get -y update
# You can install anything you need here.

# MySQL default username and password is "root"
echo "mysql-server-5.7 mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server-5.7 mysql-server/root_password_again password root" | debconf-set-selections

# Install Apache+php stack
apt-get -y install mysql-server-5.7 apache2

apt-get -y install libapache2-mod-php7.1 php7.1-mysql php7.1-curl php7.1-gd php7.1-imap php7.1-mbstring php7.1-bcmath php7.1-zip php7.1-xml libphp-pclzip php7.1 php7.1-curl php7.1-dev php7.1-xdebug php7.1-mcrypt php7.1-gmp php7.1-ldap php7.1-soap

apt-get -y install php7.1-cli

#install pear
apt-get -y install php-pear

# Update apache2 php.ini with appropriate Sugar values
sed -i 's/memory_limit =.*/memory_limit = 512M/' /etc/php/7.1/apache2/php.ini
sed -i 's/upload_max_filesize =.*/upload_max_filesize = 20M/' /etc/php/7.1/apache2/php.ini
sed -i 's/max_execution_time =.*/max_execution_time = 300/' /etc/php/7.1/apache2/php.ini
sed -i 's/;date.timezone =/date.timezone = UTC/' /etc/php/7.1/apache2/php.ini


# Suggested OPcache settings for Sugar
cat >> /etc/php/7.1/mods-available/opcache.ini <<DELIM
opcache.max_accelerated_files = 10000
opcache.memory_consumption = 256
opcache.fast_shutdown = 1
opcache.interned_strings_buffer = 16
DELIM


# Update cli php.ini for cron
sed -i 's/;date.timezone =/date.timezone = UTC/' /etc/php/7.1/cli/php.ini

# Update MySQL 5.7 defaults to remove ONLY_FULL_GROUP_BY option that causes problems with Sugar's Reports module
cat >> /etc/mysql/mysql.conf.d/sql_mode.cnf <<DELIM
[mysqld]
sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
optimizer-switch=block_nested_loop=off
DELIM
