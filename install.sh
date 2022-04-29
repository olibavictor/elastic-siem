#!/bin/bash

apt-get update && apt-get upgrade -y

apt-get install sudo curl gpg -y

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg

sudo apt-get install apt-transport-https

echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list

sudo apt-get update && sudo apt-get install "elasticsearch/kibana"

rm -rf /etc/elasticsearch/certs && rm -rf /etc/kibana/certs
rm -rf /etc/elasticsearch/elasticsearch.yml && rm -rf /etc/kibana/kibana.yml
mkdir /etc/elasticsearch/certs && mkdir /etc/kibana/certs

