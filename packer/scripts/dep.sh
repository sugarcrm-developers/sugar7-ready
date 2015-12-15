#!/bin/bash
#
# Setup the the box. This runs as root

add-apt-repository ppa:webupd8team/java -y

wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb http://packages.elastic.co/elasticsearch/1.4/debian stable main" | tee -a /etc/apt/sources.list

apt-get -y update

# You can install anything you need here.

apt-get -y install curl unzip vim php5-curl php5-gd php5-imap libphp-pclzip php-apc php5-ldap php5-memcached memcached php5 apache2 php5-curl php-devel php-xdebug

#Install Java 8, elasticsearch 1.4, then run it as a service
apt-get -y install oracle-java8-installer
apt-get -y install elasticsearch
update-rc.d elasticsearch defaults 95 10


# Update apache2 PHP.ini
perl -pi -e 's/memory_limit = 128M/memory_limit = 512M/g' /etc/php5/apache2/php.ini

perl -pi -e 's/;date.timezone =/date.timezone = UTC/g' /etc/php.ini
perl -pi -e 's/upload_max_filesize = 2M/upload_max_filesize = 20M/g' /etc/php.ini

# Update apc.ini to increase APC SHM Size
perl -pi -e 's/apc.shm_size=64M/apc.shm_size=256M/g' /etc/php.d/apc.ini
