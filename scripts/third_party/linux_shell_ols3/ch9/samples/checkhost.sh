#! /bin/bash

[ -e "/etc/hosts" ] || (echo '/etc/hosts �ɮפ��s�b.'; exit 1)
if [ "$?" -eq 1 ]; then
   exit
fi
echo '/etc/hosts �ɮצs�b�A����B�z�~�����U�h....'
