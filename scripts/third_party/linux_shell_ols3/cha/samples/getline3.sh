#! /bin/bash

getline()
{
  local i=0
  while read line
  do
	  let ++i
      if (( $i > 10 )); then
         return 3
      fi
  done < $file
  echo "$file �@�� $i �C"
}

file=$1

getline

if [ $? -eq 3 ]; then
   echo '�C�ƹL�h�A���Ū��.'
else
   echo 'getline ���槹��'
fi
