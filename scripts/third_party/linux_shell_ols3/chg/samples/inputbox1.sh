#! /bin/bash

DIA='/usr/bin/dialog'

TMP="/tmp/inputbox.$$"

DEFHNAME="sample.edu.tw"
M1="�г]�w�D���W��:"

$DIA --inputbox "$M1" 10 40 $DEFHNAME 2> $TMP

HNAME=$(cat $TMP)
[ -z "$HNAME" ] && HNAME=$DEFHNAME

rm -f "$TMP"

echo "�z�]�w���D���W�٬O: $HNAME"
