#! /bin/bash

DIA='/usr/bin/dialog'

TMP="/tmp/menu.$$"
M1="�п�ܱz���n���ɮרt��"
FSLIST="1.ext2 ��2�����X�i�ɮרt�� 2.ext3 ��3�����X�i�ɮרt�� 3.ext4 ��4�����X�i�ɮרt��"

$DIA --menu "$M1" 10 40 4 $FSLIST 2> $TMP

FSTYPE=$(cat $TMP)
[ -z "$FSTYPE" ] && FSTYPE="ext3"

rm -f "$TMP"

echo "�z��ܪ��O: $FSTYPE"
