#! /bin/bash

# �ܼƭn���ŧi��~��ϥ�
shopt -s -o nounset

ListIPcmd="/sbin/ifconfig"

IP=$($ListIPcmd | grep 'inet addr:' | grep -v '127.0.0.1' | awk '{print $2}' | awk -F: '{print $2}')

echo $IP
