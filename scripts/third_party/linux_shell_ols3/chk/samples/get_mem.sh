#! /bin/bash

# �ܼƭn���ŧi��~��ϥ�
shopt -s -o nounset

FreeCmd="/usr/bin/free"

Mem=$($FreeCmd | grep ^Mem:)

TotalMem=$(echo $Mem | awk '{print $2}')
UsedMem=$(echo $Mem | awk '{print $3}')
FreeMem=$(echo $Mem | awk '{print $4}')

echo $TotalMem $UsedMem $FreeMem

