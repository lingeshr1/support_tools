#!/bin/bash

mkdir /Users/lingesh/Downloads/$1
cd /Users/lingesh/Downloads/$1

/usr/bin/expect <<EOD
set timeout -1
spawn sftp lingesh@cloudera@sftp.hortonworks.com
expect -re "lingesh@cloudera@sftp.hortonworks.com's password:"
send -- "<PASSWORD>\n"
expect -re "sftp>"
send -- "ls\n"
expect "sftp>"
send -- "cd s-ibm/$2\n"
expect "sftp>"
send -- "get *\n"
expect "sftp>"
send -- "exit\n"
EOD
echo "you're out"

exit 1
