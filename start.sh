#!/bin/bash
## [練習] csv => LS => ES
# /home/vagrant/logstash-1.5.2/bin/logstash agent -f /home/vagrant/tibco-log/conf/csv.conf

## [練習] 官網 grok 套件的範例
# /home/vagrant/logstash-1.5.2/bin/logstash agent -f /home/vagrant/tibco-log/conf/http.conf

## [EMS]  /home/vagrant/input/tibemsd1.log
# /home/vagrant/logstash-1.5.2/bin/logstash agent -f /home/vagrant/tibco-log/conf/ems.conf

## [AS]   /home/vagrant/input/as-34160.log
# /home/vagrant/logstash-1.5.2/bin/logstash agent -f /home/vagrant/tibco-log/conf/as.conf

## [BE]   /home/vagrant/input/CCBS_Alerting-CCBS_Alerting-1.log
# /home/vagrant/logstash-1.5.2/bin/logstash agent -f /home/vagrant/tibco-log/conf/be.conf

## [BW]   /home/vagrant/input/Billing-CRM-RPL-4G-General-RPLService-1.log
# /home/vagrant/logstash-1.5.2/bin/logstash agent -f /home/vagrant/tibco-log/conf/bw.conf

