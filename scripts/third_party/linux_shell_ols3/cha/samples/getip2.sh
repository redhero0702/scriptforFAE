#! /bin/bash

MYLIB_DIR="~/libs"
if [ ! -d "$MYLIB_DIR" ]; then
   MYLIB_DIR='.'
fi

. $MYLIB_DIR/mylib1.sh

_getip eth0

ip=${FUNREPLY[0]}
if [ -n "$ip" ]; then
   echo "�D�� IP �O: $ip"
else
   echo "�䤣�� IP"
fi
