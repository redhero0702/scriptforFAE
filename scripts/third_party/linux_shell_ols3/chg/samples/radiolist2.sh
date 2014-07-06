#! /bin/bash

DIA='/usr/bin/Xdialog'

TMP="/tmp/radiolist.$$"
M1="�п�ܱz���n���ɮרt��"
NUMFS=3
FSLIST="ext2 ��2�����X�i�ɮרt�� off ext3 ��3�����X�i�ɮרt�� on ext4 ��4�����X�i�ɮרt�� off"

$DIA --radiolist "$M1" 12 40 $NUMFS $FSLIST 2> $TMP

FSTYPE=$(cat $TMP)
[ -z "$FSTYPE" ] && FSTYPE="ext3"

rm -f "$TMP"

echo "�z��ܪ��O: $FSTYPE"
