#!/bin/bash


if [[ $PACKER_BUILD_NAME == vagrant* ]]; then

    apt-get -y install ntp
	# Vagrant specific
	date > /etc/vagrant_box_build_time

	# Installing vagrant keys
	mkdir -pm 700 /home/vagrant/.ssh
	wget --no-check-certificate 'https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys
	chmod 0600 /home/vagrant/.ssh/authorized_keys
	chown -R vagrant /home/vagrant/.ssh

	# Customize the message of the day
	echo 'Sugar Development Environment' > /etc/motd

fi
