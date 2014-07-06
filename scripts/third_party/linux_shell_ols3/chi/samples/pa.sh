#! /bin/bash

# �ܼƭn���ŧi��~��ϥ�
shopt -s -o nounset

HostList=${1:?'�д��ѥD��IP�C����!'}

[ ! -f $HostList ] && echo '�D��IP�C���ɤ��s�b��! ���ˬd�@�U��!' && exit 1

# ����ɶ�
Date=$(date +'%Y%m%d%H%M')
Date_for_man=$(date +'%Y-%m-%d %H �� %M ��')

# ping ������
pno=4

# �������G�s��
padir="/var/www/pa"
pahtml="$padir/index.html" 
pahtml_now="$padir/pa-$Date.html"

#
# �禡��
#

html_head() {
[ ! -e $padir ] && mkdir -p $padir
cat <<HEAD > $pahtml_now
<html>
<head>
<title>ping alive �������G</title>
<meta HTTP-EQUIV="Refresh" CONTENT="900">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Cache-Control" content="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT="Mon, 01 Jul 2000 06:00:13 GMT">
<meta http-equiv="Content-Type" content="text/html; charset=Big5">
</head>
<body bgcolor="white">
<div align=center><font size=6><b>*** �ڪ��D���ʱ� ***</b></font></div>
<div align=center>�����ɶ��G $Date_for_man</div>
<p>
<table width="60%" align=center border=3>
<tr><td nowrap>�D���W��</td><td>IP</td><td nowrap>�̤p�����ɶ�</td><td nowrap>�̤j�����ɶ�</td><td nowrap>���������ɶ�</td></tr>
HEAD

}

html_tr() {
if [ "$1" = "PingError" ]; then
   cat <<TR >> $pahtml_now
<tr><td>$host</td><td>$ip</td><td colspan=3><font color=red><b>�L�k�s�q!!!</b></font></td></tr>
TR

else
   cat <<TR >> $pahtml_now
<tr><td>$host</td><td>$ip</td><td>$rt_min ms</td><td>$rt_max ms</td><td>$rt_avg ms</td></tr>
TR

fi
}

html_end() {
cat <<END >> $pahtml_now
</table>
</body>
</html>
END

ln -sf $pahtml_now $pahtml
}

#
# �D�{����
#

# �إ߰������G���������Y
html_head

# �B�z�j��
#-----------------------------------------------------------------------
while read host ip
do
    rt_min=
    rt_avg=
    rt_max=
    while read r
    do
        if [[ $r == round-trip* ]]; then
           rt_min=$(echo $r | awk '{print $4}' | awk -F/ '{print $1}')
           rt_avg=$(echo $r | awk '{print $4}' | awk -F/ '{print $2}')
           rt_max=$(echo $r | awk '{print $4}' | awk -F/ '{print $3}')
           html_tr $rt_min $rt_avg $rt_max
        fi 
    done < <(ping -c $pno $ip)
    if [ -z $rt_min ]; then
           html_tr PingError
    fi
done < <(cat $HostList)
#-----------------------------------------------------------------------

# �إ߰������G�������ɧ�
html_end
