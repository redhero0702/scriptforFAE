#! /bin/bash

# �ܼƭn���ŧi��~��ϥ�
shopt -s -o nounset

DIR=${1:?'�д��ѱ��ˬd�����|�A��p�G/var'}
if [[ ! $DIR == /* ]]; then
   DIR=/$DIR
fi 

declare -i size SIZE

# �Ŷ��ζq�h�֥H�W�~�C�X�ӡC�o�̥H MB �����C
SIZE=50

while read size dir
do
    if [ $size -gt $SIZE ]; then
        echo -e "$size\t\t$dir" 
    fi
done < <(find $DIR -mindepth 1 -type d -exec du -sm {} \;)
