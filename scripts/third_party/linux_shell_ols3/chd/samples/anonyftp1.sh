#! /bin/bash

# �ק� vsftpd ���]�w�ɡA�}��ΦW FTP �A��

VSFTPD_conf='/etc/vsftpd.conf'
TMP_file="/tmp/tmp.$$"

# �N anonymous_enable �ﶵ�A�]�� YES�A�o�ˡAvsftpd �N�|�}�ҰΦW�n�J FTP ���A�����\��C
sed s/^.*anonymous_enable=.*/anonymous_enable=YES/ $VSFTPD_conf > $TMP_file
mv -f $TMP_file $VSFTPD_conf
