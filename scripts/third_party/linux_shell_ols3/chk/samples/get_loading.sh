#! /bin/bash

# �ܼƭn���ŧi��~��ϥ�
shopt -s -o nounset

W="/usr/bin/w"

show_loading=$($W | head -1)

L1=$(echo $show_loading | awk '{print $9}') 
L5=$(echo $show_loading | awk '{print $10}')
L15=$(echo $show_loading | awk '{print $11}')

L1=${L1%,*}
L5=${L5%,*}
L15=${L15%,*}

echo "1�B5�B15�����������t����: $L1 $L5 $L15" 
