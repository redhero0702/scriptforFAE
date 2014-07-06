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
tmpfile=$(mktemp)

sendmail='/usr/sbin/sendmail -t'

# zip �� MIME ���A
Mime='application/x-zip-compressed'

# �n�s�X�� zip �ɦs�񪺸��|�ɦW
ZIPfile="/root/tmp/i.zip"

# zip �ɪ��ɦW�A���t���|
FileName=${ZIPfile##/*/}

# �s�X��Ȯɩ�J���ܼƤ�
EncodeTMP=

#
# �禡��
# 

# ������ɩһݪ� 32 �Ӧr�����ת��H���r��
gen_boundary() {
   local tmp
   tmp=$(head -1 /dev/urandom | od -N 2 | head -1 | awk '{print $2 * 1}' | md5sum)
   boundary="${tmp:0:32}"
}

encode_file() {
   local tmp tmp2
   cat $ZIPfile | uuencode -m $FileName > $tmpfile
   # �R���Ĥ@�C
   sed '1,1d' $tmpfile > $MsgTMP
   # �R���̫�@�C
   sed '$d' $MsgTMP > $tmpfile
   EncodeTMP=$(cat $tmpfile)
}

cr_msg() {
   # �������
   gen_boundary
   # ���ͫH��
   cat <<EOF > $MsgTMP
From: $From
To: $To
Reply-To: $From
Subject: $Subject
Content-Type: multipart/mixed; boundary="$boundary"


--$boundary
Content-Type: text/plain;
        charset="big5"


�o�O���իH!

�Ŧ^�H��!

--$boundary
Content-Type: $Mime; name="$FileName"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="$FileName"


$EncodeTMP

--$boundary--


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
   [ -f $tmpfile ] && rm -f $tmpfile
}

#
# �D�{����
#

# ��G�i���ɶi��s�X
encode_file

# �H�H
mailto

# �M�z
rmTMP

# Done.
