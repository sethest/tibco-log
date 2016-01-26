#!/bin/bash
## Elastcisearch
cd ~
wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.6.0.tar.gz
tar -zxvf elasticsearch-1.6.0.tar.gz
rm elasticsearch-1.6.0.tar.gz


## Elasticsearch UI
cd ~/elasticsearch-1.6.0
sudo bin/plugin -install mobz/elasticsearch-head


## Logstash
cd ~
wget https://download.elastic.co/logstash/logstash/logstash-1.5.2.tar.gz
tar -zxvf logstash-1.5.2.tar.gz
rm logstash-1.5.2.tar.gz