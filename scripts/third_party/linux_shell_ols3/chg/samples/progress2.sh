#! /bin/bash

{ 
  for ((i=1;i<=10;i++))
  do
      let I=10*i
      echo $I
      sleep 1
  done

  echo

  for ((i=9;i>=0;i--))
  do
      let I=10*i
      echo $I
      sleep 1
  done
} | dialog --guage "�w�˶i��" 5 60 0
