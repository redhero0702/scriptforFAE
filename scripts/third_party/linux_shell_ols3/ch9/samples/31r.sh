#! /bin/bash

# �ƾǪ��T�@��

declare -i a b
a=$1; b=$2

if ((a<b)); then
   echo "$a �p�� $b"
elif ((a>b)); then
   echo "$a �j�� $b"
else
   echo "$a ���� $b"
fi
