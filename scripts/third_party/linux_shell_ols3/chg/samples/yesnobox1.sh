#! /bin/bash

DIA='/usr/bin/dialog'

CHOICE=''

dialog --yesno "�n�~���?" 10 40
x=$?
if [ "$x" -ne 0 ]; then
   CHOICE='NO'
fi

if [ -n "$CHOICE" ]; then
   echo '�z��ܤ��~��...'
else
   echo '�z����~��...'
fi
