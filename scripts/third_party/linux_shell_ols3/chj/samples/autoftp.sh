#! /bin/bash

# �ܼƭn���ŧi��~��ϥ�
shopt -s -o nounset

Filename="test.tgz"
HOST="192.168.1.1"
USER="john"
PASS="j888"

cd /root

ftp -n $HOST <<AUTOEOF 
quote USER $USER
quot PASS $PASS
binary
put $Filename
quit
AUTOEOF
