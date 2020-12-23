#!/bin/bash

if [ "$#" -lt 2 ]
then
  echo "Usage: $0 <case_id> <yarn_application_id>"
  exit
fi

sudo -u hdfs mkdir -p /tmp/$1/app_logs /tmp/$1/event_logs

#### Event log collection ####

sudo -u hdfs hdfs dfs -get /user/spark/*/$2 /tmp/$1/event_logs/
event_log_status=$?
if [ $event_log_status -eq 0 ]; then
  cd /tmp/$1/event_logs/ && tar cfz /tmp/$1/$2_event_logs.tar.gz $2
else
  echo "Failure to get $2 Event logs from HDFS location /user/spark/*/$2"
  exit 1
fi
#################

#### Container log collection ####

sudo -u hdfs hdfs dfs -get /tmp/logs/*/logs/$2 /tmp/$1/app_logs/
app_log_status=$?
if [ $app_log_status -eq 0 ]; then
  cd /tmp/$1/app_logs/ && tar cfz /tmp/$1/$2_app_logs.tar.gz $2
else
  echo "Failure to get $2 container logs from HDFS location /tmp/logs/*/logs/$2"  
fi
#################

echo "Please upload all the *.tar.gz files listed below: "
ls -l /tmp/$1/*.tar.gz
exit 0
