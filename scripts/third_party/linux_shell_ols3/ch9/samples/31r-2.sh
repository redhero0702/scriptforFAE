#! /bin/bash

# �ƾǪ��T�@��

declare -i a b
a=$1; b=$2

if let "a<b"; then
   echo "$a �p�� $b"
elif let "a>b"; then
   echo "$a �j�� $b"
else
   echo "$a ���� $b"
fi
