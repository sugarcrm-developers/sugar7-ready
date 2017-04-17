#!/bin/bash
#
# Setup the the box. This runs as root

apt-get -y update
# You can install anything you need here.

# MySQL default username and password is "root"
echo "mysql-server-5.7 mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server-5.7 mysql-server/root_password_again password root" | debconf-set-selections

apt-get -y install software-properties-common python-software-properties perl curl zip vim

# Load Java, PHP5.6, and Elasticsearch repos
add-apt-repository ppa:ondrej/php -y
add-apt-repository ppa:webupd8team/java -y
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -

echo "deb http://packages.elastic.co/elasticsearch/1.7/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-1.7.list

apt-get -y update

# Install Apache+php54 stack
apt-get -y install mysql-server-5.7 php5.6-mysql php5.6-curl php5.6-gd php5.6-imap php5.6-mbstring php5.6-bcmath php5.6-zip php5.6-xml libphp-pclzip php-pear php5.6 apache2 php5.6-curl php5.6-dev php5.6-xdebug php5.6-mcrypt

apt-get -y remove php7*

# Install and enable JSMIN extension
pecl install jsmin-1.1.0
echo "extension=jsmin.so" > /etc/php/5.6/mods-available/jsmin.ini
ln -s /etc/php/5.6/mods-available/jsmin.ini /etc/php/5.6/apache2/conf.d/20-jsmin.ini
ln -s /etc/php/5.6/mods-available/jsmin.ini /etc/php/5.6/cli/conf.d/20-jsmin.ini

#Install Elasticsearch and Java

# Auto-accept oracle license
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
#Install Java 8, elasticsearch 1.4, then run it as a service
apt-get -y install oracle-java8-installer
apt-get -y oracle-java8-set-default
apt-get -y install elasticsearch
echo "Setting up Elasticsearch as a service"
update-rc.d elasticsearch defaults 95 10

# Update apache2 php.ini with appropriate Sugar values
sed -i 's/memory_limit =.*/memory_limit = 512M/' /etc/php/5.6//apache2/php.ini
sed -i 's/upload_max_filesize =.*/upload_max_filesize = 20M/' /etc/php/5.6/apache2/php.ini
sed -i 's/max_execution_time =.*/max_execution_time = 300/' /etc/php/5.6/apache2/php.ini
sed -i 's/;date.timezone =/date.timezone = UTC/' /etc/php/5.6/apache2/php.ini


# Suggested OPcache settings for Sugar
cat >> /etc/php/5.6/mods-available/opcache.ini <<DELIM
opcache.max_accelerated_files = 10000
opcache.memory_consumption = 256
opcache.fast_shutdown = 1
opcache.interned_strings_buffer = 16
DELIM


# Update cli php.ini for cron
sed -i 's/;date.timezone =/date.timezone = UTC/' /etc/php5/cli/php.ini

