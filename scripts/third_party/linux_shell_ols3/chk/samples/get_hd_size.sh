#! /bin/bash

# �ܼƭn���ŧi��~��ϥ�
shopt -s -o nounset

HD=${1:?'�д��ѺϺо����]�ƦW�١A��p�Ghda �� sda'}

SIZE=$(fdisk -l /dev/$HD | grep "heads,*" | awk '{print $1 * $3 * $5 / 2048}')

echo "�Ϻо� $HD ���e�q�j�p�� $SIZE MB."
