#! /bin/bash

DIA='/usr/bin/dialog'

TMP="/tmp/checklist.$$"
M1="�п�ܱz���n���ɮרt��"
FSLIST="1.ext2 ��2�����X�i�ɮרt�� on 2.ext3 ��3�����X�i�ɮרt�� on 3.ext4 ��4�����X�i�ɮרt�� off"

$DIA --separate-output --checklist "$M1" 10 40 4 $FSLIST 2> $TMP

FSTYPE=$(cat $TMP)
[ -z "$FSTYPE" ] && FSTYPE="ext3"

rm -f "$TMP"

echo "�z��ܪ��O: $FSTYPE"
