#!/bin/sh
#Author: chenjingchao
#Date: 20180411
#Mail: alfred.chen007@gmail.com

FTP_SERVER=10.131.9.180
FTP_USER=taplog
FTP_PASSWD=taplog
LOG_DIR=/opt/log/cloud

#get hostname
hostname=`hostname`
#get current date, e.g. 2018-04-11
current_date=`date -d yesterday +%Y-%m-%d`
#get the name of log file, e.g. cloud.log.2018-04-11 
file_name="cloud.log."${current_date}
file_name_ftp=${hostname:0:4}".cloud.log."${current_date}

#check if the log file had have been generated
find $LOG_DIR -name $file_name 
if [ $? -eq 0 ];then
cd $LOG_DIR
ftp -niv <<- EOF
open $FTP_SERVER
user $FTP_USER $FTP_PASSWD
bin
put $file_name $file_name_ftp 
close
bye
EOF
else exit
fi

