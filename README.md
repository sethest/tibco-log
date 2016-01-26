# tibco-log
2016-01-18 開始支援 "企業整合小組"
2016-01-30 結束

目的: 協助撰寫 logstash cfg。讓 logstash 透過 grok 套件，解析多種 TIBCO log files，然後寫入 Elasticsearch。  
環境: VirtualBox 4.3.18, Vagrant 1.7.2, Ubuntu trusty64, java 1.7.0_80-64bit    
軟體: elasticsearch 1.6.0, logstash 1.5.2  
流程: files => logstash => elasticsearch => UI
成果: 完成 ems, as, be, bw  共 4 種 log 格式。

  
註: tibco-log 目錄內的 cfg 或 bash  
  1. 雙 # 字號 (文字說明)   
  2. 單 # 字號 (option,視情況取消註解)

## Installation
請自行安裝環境  
本範例 ~ 的路徑為: /home/vagrant  

Elastcisearch:  

    cd ~
    wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.6.0.tar.gz
    tar -zxvf elasticsearch-1.6.0.tar.gz
    rm elasticsearch-1.6.0.tar.gz
    
Elasticsearch UI (https://github.com/mobz/elasticsearch-head)

    cd ~/elasticsearch-1.6.0
    sudo bin/plugin -install mobz/elasticsearch-head

Logstash:

    cd ~
    wget https://download.elastic.co/logstash/logstash/logstash-1.5.2.tar.gz
    tar -zxvf logstash-1.5.2.tar.gz
    rm logstash-1.5.2.tar.gz

## Configuration

Example: ems.conf
```
input {
  file {
    path => ["/home/vagrant/tibco-log/input/tibemsd1.log"]
    start_position => "beginning"
    sincedb_path => "/dev/null"
  }
}

filter {
  if [message] !~ "^\d" {
    drop { }
  }
  grok {
    match => [
      "message", "%{TIMESTAMP_ISO8601:Date} \[(?<Fullname>%{USERNAME}@%{HOSTNAME})\]: %{GREEDYDATA:Lastmsg}",
      "message", "%{TIMESTAMP_ISO8601:Date} %{LOGLEVEL:Loglevel}: %{GREEDYDATA:Lastmsg}",
      "message", "%{TIMESTAMP_ISO8601:Date} %{GREEDYDATA:Lastmsg}"
    ]
  }
  date {
    match => ["Date", "YYYY-MM-dd HH:mm:ss.SSS"]
  }
  grok {
    match => [
      "path", "/[^\/]+/[^\/]+/(?<Servername>[^\/]+)/[^\/]+/(?<Filename>.+)"
    ]
  }
}

output {
  elasticsearch {
    host => "127.0.0.1"
    index => "ems"
    flush_size => 1
  }
}
```

## Parameters 

- start_position => "beginning"

    從檔案的第一筆開始依序往下讀  
    
- sincedb_path => "/dev/null"

    不讀取 metadata 。(每次都重新讀檔案)

- if [message] !~ "^\d" {
    drop { }
  }

    每筆 record 當 logstash 解析時，會產生預設欄位 message，若不是數字開頭，則丟棄。
    
- grok {  match => [ "message", "1st pattern", "message", "2nd pattern", "messsage", "3rd pattern"]  }

    將 message 經過比對(當 1st不符合，則比對 2nd，若符合則不用比對3rd)，拆解成額外的欄位，越複雜的 pattern 放越前面。
    
- date { match => ["Date", "YYYY-MM-dd HH:mm:ss.SSS"] }

    透過 date 套件，將 ["欄位名", "pattern"] 的時間，同步到預設欄位 @timestamp。
    
- grok {    match => [   "path", "/[^\/]+/[^\/]+/(?<Servername>[^\/]+)/[^\/]+/(?<Filename>.+)" ] }

    透過 grok 套件，將預設欄位 path 拆解成額外的欄位。
    
- index => "ems"

    寫到 ES 的 "ems" index(DB)
    
- flush_size => 1

    每讀取一筆就刷新一次。(預設值為 500，bulk load 有助於提高寫入效能，設定 1 是方便測試。)

## Start

Step1: copy repository 64MB  (tibemsd1.log 占了 50 MB)

    git clone https://github.com/sethest/tibco-log.git
    
Step2: 啟動ES

    bash ~/tibco-log/es_start.sh
    
Step3: 啟動ES UI

    瀏覽器輸入 http://localhost:9200/_plugin/head/  (vagrant 記得要透過 forward_port)   

Step4: 啟動 logstash (請根據想要測試的檔案類型，取消註解。)

    bash ~/tibco-log/start.sh

Step5: 中斷 logstash

    Ctrl + C

## Reference
https://grokdebug.herokuapp.com/  
https://github.com/logstash-plugins/logstash-patterns-core/blob/master/patterns/grok-patterns  