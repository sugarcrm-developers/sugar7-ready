#!/bin/bash

# Bail if we are not running inside VirtualBox.
if [[ `dmidecode -s system-product-name` != "VirtualBox" ]]; then
    exit 0
fi


# mkdir -p /mnt/virtualbox
# mount -o loop $HOME/VBoxGuest*.iso /mnt/virtualbox
# sh /mnt/virtualbox/VBoxLinuxAdditions.run
# ln -s /opt/VBoxGuestAdditions-*/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions
# umount /mnt/virtualbox
# rm -rf $HOME/VBoxGuest*.iso

apt-get -y install virtualbox-guest-dkms