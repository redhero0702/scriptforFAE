#! /bin/bash

getline()
{
  local i=0
  while read line
  do
	  let ++i
      if (( $i > 10 )); then
         echo "�w�W�L 10 �C�F�A���A�~��Ū��."
         return 3
      fi
  done < $file
  echo "$file �@�� $i �C"
}

file=$1

getline

echo $?
echo 'getline ���槹��'
