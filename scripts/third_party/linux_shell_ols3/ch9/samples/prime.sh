#! /bin/bash

# ��@�Ӥj��ε���2�H�W������ơA���Ѧ���]�ƪ��s���n�C

shopt -s -o nounset

declare -i Num
declare -i i
declare -i cnt

while [[ $Num -lt 2 ]]
do
    read -p "�п�J�@�� 2 �H�W�������: " Num
done

i=2

echo -n $Num '= '
while ((Num>=i))
do
	cnt=0
	tmp=Num%i
	while [[ $tmp -eq 0 ]]
	do
		((Num/=i))
		((cnt++))
		tmp=Num%i
	done
	
	if [[ $cnt -gt 0 ]]; then
		echo -n $i 
		[ $cnt  -gt 1 ] && echo -n '^'$cnt
        [ $Num -gt 1 ] && echo -n ' * '
	fi
	
	((i>=3 ? i+=2 : i++))
done
echo 

