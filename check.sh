#!/bin/bash

## 驗證 logstash cfg 是否正確。
/home/vagrant/logstash-1.5.2/bin/logstash  -t -f /home/vagrant/tibco-log/conf/csv.conf
/home/vagrant/logstash-1.5.2/bin/logstash  -t -f /home/vagrant/tibco-log/conf/http.conf
/home/vagrant/logstash-1.5.2/bin/logstash  -t -f /home/vagrant/tibco-log/conf/ems.conf
/home/vagrant/logstash-1.5.2/bin/logstash  -t -f /home/vagrant/tibco-log/conf/as.conf
/home/vagrant/logstash-1.5.2/bin/logstash  -t -f /home/vagrant/tibco-log/conf/be.conf
/home/vagrant/logstash-1.5.2/bin/logstash  -t -f /home/vagrant/tibco-log/conf/bw.conf
