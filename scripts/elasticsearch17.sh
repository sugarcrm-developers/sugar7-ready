
apt-get -y install software-properties-common python-software-properties perl curl zip vim

# Load Java and Elasticsearch repos
add-apt-repository ppa:webupd8team/java
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -

echo "deb http://packages.elastic.co/elasticsearch/1.7/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-1.7.list

apt-get -y update

#Install Elasticsearch and Java

# Auto-accept oracle license
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
#Install Java 8, elasticsearch 1.7, then run it as a service
apt-get -y install oracle-java8-installer
apt-get -y oracle-java8-set-default
apt-get -y install elasticsearch
echo "Setting up Elasticsearch as a service"
systemctl enable elasticsearch.service