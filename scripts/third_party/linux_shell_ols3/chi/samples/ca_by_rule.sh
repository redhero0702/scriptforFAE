#! /bin/bash

shopt -s -o nounset
ACTno=${1:?'���~! �д��ѱ��إߪ��b����!'}
PKey=''
ACT=''
ACTprefix='stu'
ACTlist='accounts.txt'
declare -i k okact=0

#
# �禡��
#

# �����H�����r��
gen_key() {
    KeyLen=${1:?'���~! �д��ѱ����ͪ��r�����!'}
    declare -i N I
    declare -i KeyLen
    PKey=''
    AFB='ABCDEFGHIJKLM;0123456789#abcdefghijk_NOPQRSTUVWXYZ;mnopqrstuvwxyz^0123456789_abcdefghijk#0123456789;mnopqrstuvwxyz_ABCDEFGHIJKLM^0123456789'
    for ((I=0; I<KeyLen; I++)) 
    do
        N=$(head -1 /dev/urandom | od -N 2 | head -1 | awk '{print $2 * 1}')
	    ((N%=${#AFB}))
        PKey=$PKey${AFB:$N:1}
    done
}


#
# �D�{����
#

echo "-------------------------------------" >> $ACTlist

for ((k=1; k<=$ACTno; k++))
do
    ACT="$ACTprefix$k"
    gen_key 6
    adduser --quiet --disabled-password --gecos '' $ACT
    if [ $? -eq 0 ]; then
       echo "$ACT:$PKey" | chpasswd
       echo "�b��: $ACT | �K�X: $PKey" >> $ACTlist
       echo "-------------------------------------" >> $ACTlist
       ((okact++))
       echo "�b�� $ACT �إߧ��� ...."
    fi
done

echo "�@�إߤF $okact �ӱb��."
echo "�Ьd�� $ACTlist �o���ɮ�."
