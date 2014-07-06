#! /bin/bash

# �ק� vsftpd ���]�w�ɡA�����G'�}��/����' �ΦW FTP �A��

if [ $# -ne 1 ]; then
   echo "Usage: $0 on �� $0 off"
   exit 1
fi

OPT=$1
case "$OPT" in
   [Oo][Nn]) CMD='YES';;
   [Oo][Ff][Ff]) CMD='NO';;
   *) 
     echo '�ﶵ�榡���~! �Х� on �� off �Ӥ����ΦW�n�J���}���C' 
     exit 1
     ;;
esac

VSFTPD_conf='/etc/vsftpd.conf'
TMP_file="/tmp/tmp.$$"

sed s/^.*anonymous_enable=.*/anonymous_enable=$CMD/ $VSFTPD_conf > $TMP_file
mv -f $TMP_file $VSFTPD_conf
