#! /bin/bash

# �ܼƭn���ŧi��~��ϥ�
shopt -s -o nounset

HOST=${1:?'�n���ѥD������W�٩� IP �~���!'}
FILE=${2:?'�n���ѭn�U�����������|�~���!'}
port=80

if [[ ! $FILE == /* ]]; then
   FILE=/$FILE
fi

exec 6<>/dev/tcp/$HOST/$port

echo -e "GET $FILE HTTP/1.1" >&6
echo -e "Host: $HOST" >&6
echo -e "Connection: close\n" >&6

SaveFile=${FILE##*/}

if [ -z "$SaveFile" ]; then
   SaveFile="index.html"
fi

cat <&6 > $SaveFile

exec 6>&-
exec 6<&-
