#!/bin/bash
#
# Setup the the box. This runs as root

apt-get -y update
# You can install anything you need here.

# MySQL default username and password is "root"
echo "mysql-server-5.5 mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again password root" | debconf-set-selections

apt-get -y install python-software-properties perl curl zip vim

# Load Java, php5, and Elasticsearch repos
add-apt-repository ppa:ondrej/php5-oldstable
add-apt-repository ppa:webupd8team/java -y
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb http://packages.elastic.co/elasticsearch/1.4/debian stable main" | tee -a /etc/apt/sources.list


apt-get -y update

# Install Apache+php54 stack
apt-get -y install mysql-server php5-mysql php5-curl php5-gd php5-imap libphp-pclzip php-pear php-apc php5 apache2 php5-curl php5-dev php5-xdebug php5-mcrypt

# Install and enable JSMIN extension
pecl install jsmin-1.1.0
echo "extension=jsmin.so" > /etc/php5/mods-available/jsmin.ini
php5enmod jsmin


#Install Elasticsearch and Java


# Auto-accept oracle license
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
#Install Java 8, elasticsearch 1.4, then run it as a service
apt-get -y install oracle-java8-installer
apt-get -y install elasticsearch
echo "Setting up Elasticsearch as a service"
update-rc.d elasticsearch defaults 95 10

# Update apache2 php.ini with appropriate Sugar values
sed -i 's/memory_limit = 128M/memory_limit = 512M/' /etc/php5/apache2/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 20M/' /etc/php5/apache2/php.ini
sed -i 's/;date.timezone =/date.timezone = UTC/' /etc/php5/apache2/php.ini
sed -i 's/max_execution_time = 30/max_execution_time = 300/' /etc/php5/apache2/php.ini

# Update cli php.ini for cron
sed -i 's/;date.timezone =/date.timezone = UTC/' /etc/php5/cli/php.ini

# Adjust APC settings to more appropriate values for Sugar
echo "apc.shm_size=378M" >> /etc/php5/mods-available/apc.ini
echo "apc.max_file_size=10M" >> /etc/php5/mods-available/apc.ini

# Install node.js support
wget -qO- https://deb.nodesource.com/setup_4.x | bash -

apt-get -y update

apt-get -y install nodejs

# Install grunt-cli support
npm install -g grunt-cli

# Install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

mv composer.phar /usr/local/bin/composer
