#!/bin/bash

## 複製 ES cfg動。
cp ~/tibco-log/elasticsearch.yml ~/elasticsearch-1.6.0/config/elasticsearch.yml
cp ~/tibco-log/elasticsearch_s1.yml ~/elasticsearch-1.6.0_s1/config/elasticsearch.yml

## 啟動第一台ES
cd ~/elasticsearch-1.6.0/
bin/elasticsearch > elasticsearch.log &

## 啟動第二台ES
cd ~/elasticsearch-1.6.0_s1/
bin/elasticsearch > elasticsearch.log &
