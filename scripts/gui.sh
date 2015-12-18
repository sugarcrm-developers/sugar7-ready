#!/bin/bash

# Install Ubuntu Desktop if not using Vagrant
if [[ $PACKER_BUILD_NAME != vagrant* ]]; then
	dpkg --configure -a
	apt-get -y update
	apt-get -y install ubuntu-desktop
	# Customize the message of the day
	echo 'Sugar 7 Development Environment (Desktop)' > /etc/motd
	# Lets avoid prompting immediately for release upgrade, if users do this it will break stack config
	sed -i "s/Prompt=.*/Prompt=never/" /etc/update-manager/release-upgrades

	mkdir $HOME/sugar
	ln -s $HOME/sugar /var/www/sugar
	chown vagrant $HOME/sugar


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
You will find a SUGAR directory in your Home directory.  Download the Sugar application using Download Manager and then unzip into SUGAR directory.

You can then run Sugar installer by visiting http://localhost/sugar/ using Firefox.

local MySQL Credentials
username: root
password: root

DELIM

	# Fix permissions
	chown vagrant $HOME/sugar
	chown vagrant $HOME/Desktop/*


fi