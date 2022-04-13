#!/bin/bash

# Install node.js support
wget -qO- https://deb.nodesource.com/setup_10.x | bash -
apt-get -y install nodejs npm

# Install grunt-cli support
npm install -g grunt-cli

# Install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"

mv composer.phar /usr/local/bin/composer

# Install composer to /usr/local/bin

curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
