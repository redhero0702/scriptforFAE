#! /bin/bash

# �ܼƭn���ŧi��~��ϥ�
shopt -s -o nounset

#
# �ŧi��
#
# �H���
From='admin@jack.edu.tw'

# �����
To='admin@sample.edu.tw'

# �D��
Subject='���ճq��'

# �H�󤺮e
MsgTMP=$(mktemp)

sendmail='/usr/sbin/sendmail -t'

#
# �禡��
#

cr_msg() {
   cat <<EOF > $MsgTMP
From: $From
To: $To
Reply-To: $From
Subject: $Subject

�o�O�@�ʴ��իH��. �ФŦ^�H��!

�P�±z!

EOF

}

mailto() {
   # �إ߫H�󤺮e
   cr_msg
   # �l�H
   [ -f $MsgTMP ] && cat $MsgTMP | $sendmail
}

# �M���Ȧs��
rmTMP() {
   [ -f $MsgTMP ] && rm -f $MsgTMP
}

#
# �D�{����
#

# �H�H
mailto

# �M�z
rmTMP

# Done.
