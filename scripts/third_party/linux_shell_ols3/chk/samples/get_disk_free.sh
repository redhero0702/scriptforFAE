#! /bin/bash

# �ܼƭn���ŧi��~��ϥ�
shopt -s -o nounset

declare -i TOTAL

#
# �禡��
#

get_usedTotal() {
	TOTAL=$(df -B 1024K | grep ${p}$ | awk '{print $3}')
	echo "�w�ϥΪ��Ŷ��j�p: $TOTAL MB."
}

get_avaibleTotal() {
	TOTAL=$(df -B 1024K | grep ${p}$ | awk '{print $4}')
	echo "�Ѿl�i�Ϊ��Ŷ��j�p: $TOTAL MB."
}

#
# �D�{����
#

p=${1:?'�д��Ѥ��ΰϪ������I���W��. ��p: / �� /home �� /var'}
if [[ ! $p == /* ]]; then
   p=/$p
fi  

get_usedTotal $1
get_avaibleTotal $1
