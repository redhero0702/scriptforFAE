#! /bin/bash

getline()
{
  local i=0
  while read line
  do
	  let ++i
  done < $file
  echo "$file �@�� $i �C"
}

file=$1

getline 

echo 'getline ���槹��'
