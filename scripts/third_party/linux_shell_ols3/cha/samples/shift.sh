#! /bin/bash

echo "\$@ �����: $@"
while shift
do
   [ -n "$1" ] && echo "shift 1 ���A\$@ ���ܤ�: $@"
done
