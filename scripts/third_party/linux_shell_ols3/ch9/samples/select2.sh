#! /bin/bash

PS3='�п��: '
menu="/ /root /etc /home /usr/local /var/log" 
select f in $menu
do
   echo "�z��J���s���O $REPLY, ��ܪ��ؿ��O: $f"
done
