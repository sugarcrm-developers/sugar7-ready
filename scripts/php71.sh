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


# Load Java and Elasticsearch repos
add-apt-repository ppa:webupd8team/java
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -

echo "deb http://packages.elastic.co/elasticsearch/1.7/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-1.7.list

apt-get -y update

# Install Apache+php stack
apt-get -y install mysql-server-5.7 apache2

apt-get -y install libapache2-mod-php7.1 php7.1-mysql php7.1-curl php7.1-gd php7.1-imap php7.1-mbstring php7.1-bcmath php7.1-zip php7.1-xml libphp-pclzip php7.1 php7.1-curl php7.1-dev php7.1-xdebug php7.1-mcrypt

apt-get -y install php7.1-cli

#install pear
apt-get -y install php-pear

#Install Elasticsearch and Java

# Auto-accept oracle license
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
#Install Java 8, elasticsearch 1.7, then run it as a service
apt-get -y install oracle-java8-installer
apt-get -y oracle-java8-set-default
apt-get -y install elasticsearch
echo "Setting up Elasticsearch as a service"
systemctl enable elasticsearch.service

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

