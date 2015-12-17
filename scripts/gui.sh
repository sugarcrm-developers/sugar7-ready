#!/bin/bash

# Install Xubuntu Desktop if not using Vagrant
if [[ $PACKER_BUILD_NAME != vagrant* ]]; then
	dpkg --configure -a
	apt-get -y update
	apt-get -y install xubuntu-desktop --no-install-recommends
fi