#! /bin/bash

getline()
{
  local i=0
  while read line
  do
	  let ++i
  done < $1
  echo "$file �@�� $i �C"
}

file=$1

getline $file

echo 'getline ���槹��'
