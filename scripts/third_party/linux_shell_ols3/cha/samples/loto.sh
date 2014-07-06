#! /bin/bash

# �ܼƭn���ŧi��~��ϥ�
shopt -s -o nounset

# m �ΨӼȦs���o�� 6 �Ӹ��X
m=

#
# �禡��
#

# ���o�@�� 1 ~ 42 �����X
function GetLOTO () {
   local r

   r=$(( $RANDOM % 43 ))

   # �Y�Ӹ��� 0, �h���H�[ 1
   if [ $r -eq 0 ]; then
   	  r=$[ r + 1 ]
   fi

   # �ϨC�@�Ӹ��X���ΤG��ƨӪ�ܡA���� 10 �̡A�b��e���� 0
   if [ $r -le 9 ]; then
      echo "0$r"
   else
      echo $r
   fi
}


function GenNumAndCheckRepeat () {
   local n

   # ���o 6 �Ӹ��X�A�åB���H�Ƨ�
   m=$({ GetLOTO;  GetLOTO;  GetLOTO;  GetLOTO;  GetLOTO;  GetLOTO; } | sort -n)
      
   # ��o 6 �Ӹ��X�Ȯ� copy �@���� n
   n="$m"

   # �ˬd�o 6 �Ӹ��X���L����
   n=$(echo $n | tr ' ' '\n' | uniq -d)

   # �Y $n ����, ��ܨS������, �h�Ǧ^�u ( 0 )
   if [ -z "$n" ]; then
      return 0
   else
      # �Y $n �D��, ��ܦ�����, �h�Ǧ^�� ( 1 )
      return 1
   fi
}

#
# �D�{����
#

# �P�_�ϥΪ̬O�_���Ѳռ�
if [ $# -ne 1 ]; then
   echo "�ϥΪk: $0 �ռ�"
   exit
fi

# �ռƭn���� 1 ~ 99 ��
if [ "$1" -lt 1 -o "$1" -gt 99 ]; then
   echo "�ϥΪk: $0 [1-99]��"
   exit
fi


# i ���֭p���ռ�
declare -i i=1 j

# �� i �p��ε���ռƮɡA�K�� while �j�鲣�ͤU�@�ռֱm���X
while [ $i -le "$1" ]
do
    # ���o 6 �Ӹ��X
    GenNumAndCheckRepeat

    # �Y�����СA�h���o 6 �Ӹ��X
    if [ $? -ne 0 ]; then
       continue
    fi

    # �վ��X�榡
    j=$i
    if [ $j -le 9 ]; then
       echo -n "�� 0$j ��: "
    else
       echo -n "�� $j ��: "
    fi

    # ����즹�A��ܸӲո��X�S�����СA���H��ܥX��
    echo $m
 
    # �ռ� �[ 1 
    i=$[ i + 1 ]
done

