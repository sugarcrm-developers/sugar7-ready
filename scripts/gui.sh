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


fi