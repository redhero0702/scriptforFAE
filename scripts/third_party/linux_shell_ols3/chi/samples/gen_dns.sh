#! /bin/bash

# �ܼƭn���ŧi��~��ϥ�
shopt -s -o nounset

#---------------------------------------------------
# �i�ק��

# ����W��
domain="mdjh.tnc.edu.tw"

# �����N��
network="163.26.197.0"

# netmask�G�Y�O 1 �� C class�A�г]�� 24�F 1/2 C �г]�� 25�F
# 1/4 C�A�г]�� 26�C�䥦�̦�����
mask="24"

# ���q IP �e 3 �X�A�p��G163.26.197.1 �� '163.26.197'
ipf3="163.26.197"

# DNS �D�� IP �� 4 �X�A��p�G163.26.197.1 �� 1
DNS_ip4="1"

# �Y���ĤG�� DNS�A�Цb�o�̫��w�� IP �� 4 �X�A
# ��p�G163.26.197.2 �� 2
DNS2_ip4="2" 
#---------------------------------------------------
# �]�w�ɦW
#
binddir="/etc/bind"
bindboot="named.conf"
localhost="localhost"
rev127="rev-127.0.0"
namedca="named.ca"
rndckey="rndc.key"
zonedb=db."$domain"
revdb=db."$ipf3"
auth_zones="auth_zones.conf"

#
# �䥦�ܼƫŧi��
# 
declare -i ip1
declare -i ip2
declare -i ip3
declare -i num
DNS_IP="$ipf3.$DNS_ip4"
rev3ip=
DNS2_IP="$ipf3.$DNS2_ip4" 

#
# �禡��
#

chk_num() {
    num=${1:?'�д��ѱ��ˬd���Ʀr'}
    if [ $num -lt 0 -o $num -gt 255 ]; then
       echo 'IP ���C�@�Ӳզ��Ʀr������0~255����.'
       exit 1
    fi
}

# �ˬd ip
chk_ip() {
    IPF3=${1:?'�д��Ѻ��q IP �e 3 �X'}
    # ���X�U�� IP �զ�
    ip1=$(echo $IPF3 | awk -F. '{print $1}')
    ip2=$(echo $IPF3 | awk -F. '{print $2}')
    ip3=$(echo $IPF3 | awk -F. '{print $3}')
    chk_num $ip1
    chk_num $ip2
    chk_num $ip3
    rev3ip="$ip3.$ip2.$ip1"
}

# �إ� named.conf
cr_namedconf() {
cat <<NORECU > $binddir/$bindboot
options {
	directory "$binddir";
	allow-transfer {
		$DNS2_IP; // Secondary DNS
	};
};

logging {
	category lame-servers{null;};
};

// �o�̦C�X�i�H�ϥλ��j���d�ߪ� IP�A�Цۦ�W�K
acl allow_clients { 127.0.0.1; $network/$mask;};

// �b acl ���� IP �i�H�����j���d��
view "recursive" {
        match-clients { allow_clients; };
        recursion yes;
        include "auth_zones.conf";
};

// ���b acl ���� IP �ڵ��ϥλ��j���d��
view "external" {
        match-clients { any; };
        recursion no;
        include "auth_zones.conf";
};

NORECU

cat <<AUTH > $binddir/$auth_zones
zone "." {
	type hint;
	file "$namedca";
};

zone "localhost" { 
	type master;
	file "$localhost";
};

zone "0.0.127.in-addr.arpa" {
	type master;
	file "$rev127";
};

zone "$domain" {
	type master;
	file "$zonedb";
};

zone "$rev3ip.in-addr.arpa" {
	type master;
	file "$revdb";
};
AUTH


}

# �إߥ�����
cr_db() {
cat <<ZONEDB > $binddir/$zonedb
\$TTL 86400
@	IN	SOA	dns.$domain.	admin.dns.$domain. (
			2006030800 	; serial
			86400 		; refresh
			1800 		; retry
			1728000 	; expire
			1200    	; Negative Caching
			)
      IN	NS	dns.$domain.
dns		IN	A	$DNS_IP
@		IN	MX	0	mail.$domain.
$domain. 	IN 	A 	$DNS_IP
;
www   IN	CNAME	dns.$domain.
;
mail  IN	A	$DNS_IP
;
ZONEDB

}

# �إߤϸ���
cr_rev() {
cat <<REVDB > $binddir/$revdb
\$TTL 86400
@	IN	SOA	dns.$domain.	admin.dns.$domain. (
			2000082619 	; serial
			86400 		; refresh
			1800 		; retry
			1728000 	; expire
			1200    	; Negative Caching
			)
      IN	NS	dns.$domain.
;
$DNS_ip4  IN	PTR	dns.$domain.
;
REVDB

}

cr_localhost() {
cat <<LOCALHOST > $binddir/$localhost
\$TTL 86400
@	IN	SOA	dns.$domain.	admin.dns.$domain. (
			2000082619 	; serial
			86400 		; refresh
			1800 		; retry
			1728000 	; expire
			1200    	; Negative Caching
			)
      IN	NS	dns.$domain.
;
localhost.		IN	A	127.0.0.1
LOCALHOST

cat <<REV127 > $binddir/$rev127
\$TTL 86400
@	IN	SOA	dns.$domain.	admin.dns.$domain. (
			2000082619 	; serial
			86400 		; refresh
			1800 		; retry
			1728000 	; expire
			1200    	; Negative Caching
			)
      IN	NS	dns.$domain.
;
1     IN	PTR	localhost.
REV127
}

# �إ� rndc.key
cr_rndckey() {
    [ ! -e "/usr/sbin/rndc-confgen" ] && echo 'rndc-confgen ���s�b�A�L�k���� rndc.key' && exit 1
    /usr/sbin/rndc-confgen -a -c $binddir/$rndckey
}

# �إ߮ں����T��
cr_namedca() {
cat<<NAMEDCA > $binddir/$namedca
;       This file holds the information on root name servers needed to
;       initialize cache of Internet domain name servers
;       (e.g. reference this file in the "cache  .  <file>"
;       configuration file of BIND domain name servers).
;
;       This file is made available by InterNIC 
;       under anonymous FTP as
;           file                /domain/named.cache
;           on server           FTP.INTERNIC.NET
;       -OR-                    RS.INTERNIC.NET
;
;       last update:    Jan 29, 2004
;       related version of root zone:   2004012900
;
;
; formerly NS.INTERNIC.NET
;
.                        3600000  IN  NS    A.ROOT-SERVERS.NET.
A.ROOT-SERVERS.NET.      3600000      A     198.41.0.4
;
; formerly NS1.ISI.EDU
;
.                        3600000      NS    B.ROOT-SERVERS.NET.
B.ROOT-SERVERS.NET.      3600000      A     192.228.79.201
;
; formerly C.PSI.NET
;
.                        3600000      NS    C.ROOT-SERVERS.NET.
C.ROOT-SERVERS.NET.      3600000      A     192.33.4.12
;
; formerly TERP.UMD.EDU
;
.                        3600000      NS    D.ROOT-SERVERS.NET.
D.ROOT-SERVERS.NET.      3600000      A     128.8.10.90
;
; formerly NS.NASA.GOV
;
.                        3600000      NS    E.ROOT-SERVERS.NET.
E.ROOT-SERVERS.NET.      3600000      A     192.203.230.10
;
; formerly NS.ISC.ORG
;
.                        3600000      NS    F.ROOT-SERVERS.NET.
F.ROOT-SERVERS.NET.      3600000      A     192.5.5.241
;
; formerly NS.NIC.DDN.MIL
;
.                        3600000      NS    G.ROOT-SERVERS.NET.
G.ROOT-SERVERS.NET.      3600000      A     192.112.36.4
;
; formerly AOS.ARL.ARMY.MIL
;
.                        3600000      NS    H.ROOT-SERVERS.NET.
H.ROOT-SERVERS.NET.      3600000      A     128.63.2.53
;
; formerly NIC.NORDU.NET
;
.                        3600000      NS    I.ROOT-SERVERS.NET.
I.ROOT-SERVERS.NET.      3600000      A     192.36.148.17
;
; operated by VeriSign, Inc.
;
.                        3600000      NS    J.ROOT-SERVERS.NET.
J.ROOT-SERVERS.NET.      3600000      A     192.58.128.30
;
; operated by RIPE NCC
;
.                        3600000      NS    K.ROOT-SERVERS.NET.
K.ROOT-SERVERS.NET.      3600000      A     193.0.14.129 
;
; operated by ICANN
;
.                        3600000      NS    L.ROOT-SERVERS.NET.
L.ROOT-SERVERS.NET.      3600000      A     198.32.64.12
;
; operated by WIDE
;
.                        3600000      NS    M.ROOT-SERVERS.NET.
M.ROOT-SERVERS.NET.      3600000      A     202.12.27.33
; End of File

NAMEDCA

}


#
# �D�{����
#

chk_ip $ipf3

cr_namedconf
cr_db
cr_rev
cr_localhost
cr_rndckey
cr_namedca

echo '����!'
