#! /bin/bash

DIA='/usr/bin/dialog'

$DIA --msgbox "�o�O�@�Ӵ���" 10 40
x=$?
if [ "$x" -eq 0 ]; then
   echo '�z���F ENTER ��'
elif [ "$x" -eq 255 ]; then
   echo '�z���F ESC ��'
else
   echo '���������~: �z�i����F Ctrl-C ��'
fi
