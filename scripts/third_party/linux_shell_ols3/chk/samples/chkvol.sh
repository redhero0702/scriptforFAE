#! /bin/bash

# �ܼƭn���ŧi��~��ϥ�
shopt -s -o nounset

#
# �ŧi��
#
# ���ˬd�����ΰϡA�ХH�ťչj�}�C
partitions="/ /bk /backup"

# �H���
From='admin@jack.edu.tw'

# �����
To='admin@sample.edu.tw'

# �D��
Subject='���ΰϪŶ��ϥζq�ʴ��q��'

# �H�󤺮e
Msgbody=

# ĵ�ܦʤ���A�w�]�F�� 90% �N�o�Xĵ�i�q��
declare -i AlertPcent=90

# TOTAL: �ϺЪŶ��w�ϥζq, TOTALavl: �Ѿl�i�ΪŶ�
declare -i TOTAL TOTALavl

mail='/usr/bin/mail'
HostCmd="/bin/hostname"

# �D���W��
HostName=$($HostCmd)

#
# �禡��
#

# �w�ζq�ʤ���
get_usedTotalPcent() {
    local tmp pcent
    declare -i pcent
    # ���o�w�ζq���ʤ���A��p 59%
	tmp=$(df -B 1024K | grep ${p}$ | awk '{print $5}')
    # �h�� % ���Ÿ�
    pcent=${tmp%\%*}
    return $pcent
}

# �w�ζq
get_usedTotal() {
	TOTAL=$(df -B 1024K | grep ${p}$ | awk '{print $3}')
}

# �Ѿl�i�ζq
get_avaibleTotal() {
	TOTALavl=$(df -B 1024K | grep ${p}$ | awk '{print $4}')
}

# �l�H�q��
mailto() {
   echo "$Msgbody" | mail -a "From: $From" -s "$Subject" $To
}

#
# �D�{����
#

p=
pcent=
if [ -n "$partitions" ]; then
   for p in $partitions
   do
      get_usedTotalPcent $p
      pcent=$?

      # �O�_�w�Fĵ�ܦʤ���
      if [ $pcent -ge $AlertPcent ]; then
         get_usedTotal $p
         get_avaibleTotal $p
         Msgbody=$Msgbody" ���ΰ� $p �ثe�ϥζq $TOTAL MB�A�w�F $pcent%�A�Ѿl�i�ΪŶ� $TOTALavl MB�A�о��t�B�z."
      fi
   done
   if [ -n "$Msgbody" ]; then
      Msgbody="$HostName �D��: "$Msgbody
      mailto
   fi
fi
