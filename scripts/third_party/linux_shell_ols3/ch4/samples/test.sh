#! /bin/bash
#
# �γ~: �o�O�@��²�檺 shell �ܽd�{��
#
#

function show_name() {
		 echo "���Ө�O $1�A�z $2 �j�j�A�Ӧ� $3"
}

name="$1"
ip="163.26.197.1"
today=`date +%F`

if [ $# != 1 ]; then
   echo "Usage: ./$0 [�ϥΪ̦W��]"
   exit
fi

show_name "$today" "$name" "$ip" 

sleep 5

echo
echo "Bye-Bye ;-)"
