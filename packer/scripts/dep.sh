#!/bin/bash
#
# Setup the the box. This runs as root

apt-get -y update
# You can install anything you need here.

# MySQL default username and password is "root"
echo "mysql-server-5.5 mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again password root" | debconf-set-selections

apt-get -y install python-software-properties perl curl unzip vim php5-curl php5-gd php5-imap libphp-pclzip php-apc php5-ldap php5-memcached memcached php5 apache2 php5-curl php5-dev php5-xdebug

#Setup more required repos
add-apt-repository ppa:webupd8team/java -y

wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb http://packages.elastic.co/elasticsearch/1.4/debian stable main" | tee -a /etc/apt/sources.list

apt-get -y update

#Install Java 8, elasticsearch 1.4, then run it as a service
apt-get -y install oracle-java8-installer
apt-get -y install elasticsearch
update-rc.d elasticsearch defaults 95 10


# Update apache2 php.ini
perl -pi -e 's/memory_limit = 128M/memory_limit = 512M/g' /etc/php5/apache2/php.ini
perl -pi -e 's/upload_max_filesize = 2M/upload_max_filesize = 20M/g' /etc/php5/apache2/php.ini

# Update cli php.ini for cron
perl -pi -e 's/;date.timezone =/date.timezone = UTC/g' /etc/php5/cli/php.ini

