#! /bin/bash

DIA='/usr/bin/dialog'

TMP="/tmp/passwordbox.$$"

DEFPWD='b2d is best'
M1="�г]�w�@�ձK�X:"

$DIA --passwordbox "$M1" 10 40 2> $TMP

PWD=$(cat $TMP)
[ -z "$PWD" ] && PWD=$DEFPWD

rm -f "$TMP"

echo "�z�]�w���K�X�O: $PWD"
