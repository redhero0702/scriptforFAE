#! /bin/bash

DIA='/usr/bin/Xdialog'

TMP="/tmp/inputbox.$$"

DEFACT="root"
DEFPWD="password999"
M1="�г]�w�b���K�X:"

$DIA --password --2inputsbox "$M1" 16 40 "�b��" $DEFACT "�K�X" $DEFPWD 2> $TMP

R=( $(cat $TMP | awk -F/ '{print $1,$2}') )

[ -z "${R[0]}" ] && R[0]=$DEFACT
[ -z "${R[1]}" ] && R[1]=$DEFPWD

rm -f "$TMP"

echo "�z�]�w���b���O: ${R[0]}"
echo "�z�]�w���K�X�O: ${R[1]}"
