#! /bin/bash

DIA='/usr/bin/Xdialog'

TMP="/tmp/inputbox.$$"

DEFPWD="password999"
M1="�г]�w�K�X:"

$DIA --password --inputbox "$M1" 10 40 $DEFPWD 2> $TMP

PWD=$(cat $TMP)
[ -z "$PWD" ] && PWD=$DEFPWD

rm -f "$TMP"

echo "�z�]�w���K�X�O: $PWD"
