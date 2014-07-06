#! /bin/bash

#
# �ŧi��
#

# �|�۰ʭ˱a
tape=st0
# ���۰ʭ˱a
ntape=nst0

#
# �禡��
#

# �˱a
rewind_tape() {
   mt -f /dev/$ntape rewind
}

# ����̫�@���ɮץ���
to_end() {
   mt -f /dev/$ntape eod
}

# �h�X�ϱa�X
offline() {
   mt -f /dev/$ntape offline
}

# �d�ݪ��A
check_status() {
   mt -f /dev/$ntape staus
}

# ���Ჾ�� n ���ɮסA$1 �����ʪ��ɮ׼�
forward_n() {
   mt -f /dev/$ntape fsf $1
}

# ���e���� n-1 ���ɮסA$1 �������ʪ��ɮ׼�+1
# �Ҧp�n���e���� 1 ���ɮסA�n���� back_n 2
back_n() {
   mt -f /dev/$ntape bsfm $1
}

# �d�X�@���X�ӳƥ���
count_total() {
   local t
   # ����ϱa�̥���
   mt -f /dev/$ntape eod
   # ���o�������ɮ׼�
   t=$(mt -f /dev/nst0 status | grep '^File number' | awk -F, '{print $1}' | awk -F= '{print $2}')
   return $t
}
