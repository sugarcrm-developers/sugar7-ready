
apt-get -y install software-properties-common python-software-properties perl curl zip vim
apt-get -y install apt-transport-https

# Load Java and Elasticsearch repos
add-apt-repository ppa:webupd8team/java
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -

wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.0.1-amd64.deb
sudo dpkg -i elasticsearch-7.0.1-amd64.deb
apt-get -y update

#Install Elasticsearch and Java

#Install Java 8, elasticsearch 7.0, then run it as a service

apt-get -y install default-jre
apt-get -y install elasticsearch

echo "Setting up Elasticsearch as a service"
/bin/systemctl daemon-reload
/bin/systemctl enable elasticsearch.service