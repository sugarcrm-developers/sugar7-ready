
# Install Xubuntu Desktop if not using Vagrant
if [[ $PACKER_BUILD_NAME != vagrant* ]]; then
	apt-get -y install xubuntu-desktop 
fi