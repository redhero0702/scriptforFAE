#! /bin/bash

shopt -s -o nounset

ACTfile=${1:?'���~! �д��ѱb����!'}
[ ! -f "$ACTfile" ] && echo "�b���� $ACTfile ���s�b." && exit 1

declare -i okdel=0
act=''
password=''

#
# �D�{����
#
while read act password 
do
    userdel -r $act
    if [ $? -eq 0 ]; then
       ((okdel++))
       echo "�w�R���b�� $act ...."
    fi
done < <(awk 'BEGIN{FS=":"} /\w:\w/ {print $1, $2}' $ACTfile)

echo "�@�R���F $okdel �ӱb��."
