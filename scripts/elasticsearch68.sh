
apt-get -y install software-properties-common python-software-properties perl curl zip vim
apt-get -y install apt-transport-https

# Load Java and Elasticsearch repos
add-apt-repository ppa:linuxuprising/java
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
apt-get -y update

echo debconf shared/accepted-oracle-license-v1-2 select true | debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-2 seen true | debconf-set-selections

apt-get -y install oracle-java13-installer oracle-java13-set-default

wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.8.6.deb
sudo dpkg -i elasticsearch-6.8.6.deb

echo "Setting up Elasticsearch as a service"
/bin/systemctl daemon-reload
/bin/systemctl enable elasticsearch.service