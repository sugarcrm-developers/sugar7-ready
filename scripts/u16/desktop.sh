#!/bin/bash

# Install Ubuntu Desktop if not using Vagrant
if [[ $PACKER_BUILD_NAME != vagrant* ]]; then

	# Setup link to /var/www/ from Home directory

	mkdir $HOME/sugar
	ln -s $HOME/sugar /var/www/html/sugar

	# Setup Desktop

	mkdir $HOME/Desktop

	cat > $HOME/Desktop/PHPINFO.desktop <<DELIM
[Desktop Entry]
Encoding=UTF-8
Name=PHPINFO
Type=Link
URL=http://localhost/phpinfo.php
Icon=text-html
DELIM

	cat > $HOME/Desktop/Developer\ Guide.desktop <<DELIM
[Desktop Entry]
Encoding=UTF-8
Name=Sugar Developer Guide
Type=Link
URL=http://support.sugarcrm.com/Documentation/Sugar_Developer
Icon=text-html
DELIM

	cat > $HOME/Desktop/Sugar\ Documentation.desktop <<DELIM
[Desktop Entry]
Encoding=UTF-8
Name=Sugar Documentation
Type=Link
URL=http://support.sugarcrm.com/Documentation/Sugar_Versions
Icon=text-html
DELIM

	cat > $HOME/Desktop/SugarCRM\ Download\ Manager.desktop <<DELIM
[Desktop Entry]
Encoding=UTF-8
Name=SugarCRM Download Manager
Type=Link
URL=http://store.sugarcrm.com/download
Icon=text-html
DELIM

	cat > $HOME/Desktop/README <<DELIM
# Sugar 7 Ready Virtual Machine

This machine is pre-configured to run Sugar 7 with ease.  It is preconfigured with supported versions of Apache, PHP, MySQL, and Elasticsearch.

Steps to set up Sugar on this VM

- Step 1: Download the Sugar application using Download Manager.
- Step 2: Unzip it into SUGAR directory in your Home directory.  This directory is linked to the local web server (Apache).
- Step 3: Start Sugar installer by visiting unzipped Sugar application at http://localhost/sugar/ using Firefox.
- Step 4: Follow steps in Installation Wizard.  Elasticsearch and MySQL details below.

## local Elasticsearch Server
Should be same as defaults in Wizard.
hostname: localhost
port: 9200

## local MySQL Server
username: root
password: root

DELIM

	# Fix permissions
	chown -R vagrant:vagrant /home/vagrant
    find /home/vagrant/ -type d -exec chmod 750 {} +
    find /home/vagrant/ -type f -exec chmod 640 {} +


fi
