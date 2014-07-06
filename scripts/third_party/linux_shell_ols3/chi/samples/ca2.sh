#! /bin/bash

shopt -s -o nounset

ACTfile=${1:?'���~! �д��ѱb����!'}
[ ! -f "$ACTfile" ] && echo "�b���� $ACTfile ���s�b." && exit 1

declare -i okact=0
act=''
password=''

#
# �禡��
#

create_homepage() {
    U=${1:?'���~! �д��ѱb��!'}
    HPdir="/home/$U/public_html"
    Idx="$HPdir/index.html"
    mkdir -p $HPdir
    chmod 755 $HPdir
    cat <<EOF > $Idx
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=big5">
<title>$U ������</title>
</head>
<body bgcolor="#FFFFFF">
<div align="center">
<h1>$U ������</h1>
</div>
</head>
</html>
EOF

    chown -R $U.$U /home/$U
}

#
# �D�{����
#
while read act password 
do
    adduser --quiet --disabled-password --gecos '' $act
    if [ $? -eq 0 ]; then
       echo "$act:$password" | chpasswd
       create_homepage $act
       ((okact++))
       echo "�b�� $act �إߧ��� ...."
    fi
done < <(awk 'BEGIN{FS=":"} /\w:\w/ {print $1, $2}' $ACTfile)

echo "�@�إߤF $okact �ӱb��."

