#! /bin/bash

# �� $2 �����e��V���[�� $1 ���w���ɮפ�
appendfile() {
   echo "$2" >> "$1"
}

Dir=~/tmp
OutFile="$Dir/tmp.txt"

# �Y�ؿ����s�b�A�h�}�s�ؿ�
[ -e $Dir ] || mkdir -p $Dir 

appendfile $OutFile "�禡�]�i�H�o�˥�"
appendfile $OutFile "�o�O�禡���t�@�إΪk"
appendfile $OutFile "Over."
