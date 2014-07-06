#! /bin/bash
if [ $# -ne 1 ]; then
   echo "Usage: $0 ��{�W������r"
   exit 1
fi
proc=$1
pid=$(ps auxw | grep $proc | grep -v grep | grep -v $0 | awk '{print $2}')

if [ -n "$pid" ]; then
   echo $pid
else
   echo '�䤣�즹��{.'
fi
