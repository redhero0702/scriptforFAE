#! /bin/bash

# �ܼƭn���ŧi��~��ϥ�
shopt -s -o nounset

Filename="/root/bktest.tgz"
HOST="192.168.1.2"
Remotedir="/root/tmp"
DST=root@"$HOST":$Remotedir

/usr/bin/scp $Filename $DST
