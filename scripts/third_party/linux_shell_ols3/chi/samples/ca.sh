#! /bin/bash

shopt -s -o nounset

ACTfile=${1:?'���~! �д��ѱb����!'}
[ ! -f "$ACTfile" ] && echo "�b���� $ACTfile ���s�b." && exit 1

declare -i okact=0
act=''
password=''

#
# �D�{����
#
while read act password 
do
    adduser --quiet --disabled-password --gecos '' $act
    if [ $? -eq 0 ]; then
       echo "$act:$password" | chpasswd
       ((okact++))
       echo "�b�� $act �إߧ��� ...."
    fi
done < <(awk 'BEGIN{FS=":"} /\w:\w/ {print $1, $2}' $ACTfile)

echo "�@�إߤF $okact �ӱb��."

