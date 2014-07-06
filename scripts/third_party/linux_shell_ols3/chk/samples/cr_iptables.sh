#! /bin/bash

# �ܼƭn���ŧi��~��ϥ�
shopt -s -o nounset

#
# �ŧi��
#

ListIPcmd="/sbin/ifconfig"
# �����ͪ� iptables �]�w��
RC="rc.local"
# �D�� IP
IP=
# �����N��
NET=
# �����N��/�s�� bit �O 1 ���줸�ơA��p 192.168.1.0/24
NETWORK=
# �����B�n
MASK=
# �s�� bit �O 1 ���줸��
MASKBITS=
# �G�i��U�줸�����ȦC��
masklist="128 64 32 16 8 4 2 1"
# �O�s���j�r����C�����e
Save_IFS=$IFS

#
# �禡��
#

trans_bits() {
    local a i q s
    declare -i a i q s=0
    # a �O�ǤJ����ơA�p��ε��� 255
    a=$1
    # ��_�w�]�����j�r�����
    IFS=$Save_IFS
    # �N a �N���G�i��ơA�p��� bit �O 1 ���Ӽ�
    for i in $masklist
    do
        # q �O a ���H�U�줸���Ȫ��ӡA��p 255/128 �o�Ӭ� 1
        q=$((a/i))
        # s �ΥH�έp bit �O 1 ���Ӽ�
        ((s+=q))
        # ��s a ���ȡA��p 255 - 128*1 = 127�A�A�i�J�U�@�Ӱj��
        a=$((a-q*i))
    done
    # �Ǧ^ bit �O 1 ���Ӽ�
    return $s
}

get_bit1() {
    local i mask
    declare -i i mask

    # �]�������B�n�H '.' ���j�A�ҥH�A�N���j�r���ܼƳ]�� '.'
    # �p���A�i��X�����B�n���|�ӼƦr
    IFS='.'
    for i in $1
    do
        # �N�����B�n���C�@�ӼƦr�A�ǤJ trans_bits �禡�A�p�� bit �O 1 ���Ӽ�
        trans_bits $i
        # mask �έp bit �O 1 ���`�Ӽ�
        ((mask+=$?))
    done
    # ��_���j�r���ܼƪ����e
    IFS=$Save_IFS
    # �Ǧ^ bit �O 1 ���`�Ӽ�
    return $mask
}

# ���o�����B�n
get_mask() {
    # MASK �������B�n�A��p 255.255.255.0
    MASK=$($ListIPcmd | grep 'Mask:' | grep -v '127.0.0.1' | awk '{print $4}' | awk -F: '{print $2}')
}

# ���o�����B�n�줸��
get_mask_bits() {
    # MASK �������B�n�A��p 255.255.255.0
    if [ -z "$MASK" ]; then
       MASK=$($ListIPcmd | grep 'Mask:' | grep -v '127.0.0.1' | awk '{print $4}' | awk -F: '{print $2}')
    fi
    # �s�� get_bit1 �p��줸�Ȭ� 1 ���Ӽ�
    get_bit1 "$MASK"
    return $?
}

# ���o�D���Ҧb���q�������N��
get_netip() {
    local ip4 f3ip mask4 L U c net
    declare -i mask4 L U c net

    IP=$($ListIPcmd | grep 'inet addr:' | grep -v '127.0.0.1' | awk '{print $2}' | awk -F: '{print $2}')

    # IP ���� 4 �ӼƦr�A��p 192.168.1.78 �� 78
    ip4=${IP##*.}

    # IP ���e 3 �ӼƦr�A��p 192.168.1.78 �� 192.168.1
    f3ip=${IP%.*}    

    # ���o�ثe���d�������B�n
    get_mask

    # �����B�n���� 4 �ӼƦr�A��p 255.255.255.192 �� 192
    mask4=${MASK##*.}

    # L �P mask4�A��p 192
    L=mask4

    # U ���D�����ݺ��q�i�� IP �ơA��p 256-192=64
    U=256-L

    # �p��D���� IP �O���b���@�Ӻ��q�A��p 78/64 ����Ʊo c=1�A���� 2 �Ӻ��q(0��Ĥ@�Ӻ��q)
    c=ip4/U
   
    # ���q�N���A��p 64*1=64�A��ܲ� 2 �Ӻ��q���N���� x.x.x.64
    net=U*c
    NET=$f3ip.$net
}


gen_iptables() {
  cat <<EOF > $RC
#! /bin/bash
#
# iptables �d��
# written by OLS3 (ols3@lxer.idv.tw)
#
# �Цۦ�Ѧҭק�A����Ѯ����Y�i�ҥθӶ��]�w
#

#/sbin/route add -net 192.168.1.0 netmask 255.255.255.0 gw 192.168.1.1

###-----------------------------------------------------###
# �]�w iptables �����|
###-----------------------------------------------------###
echo "Set path of iptables"
echo

IPTABLES="/sbin/iptables"

#/sbin/modprobe ip_conntrack
#/sbin/modprobe ip_conntrack_ftp
#/sbin/modprobe iptable_nat
#/sbin/modprobe ip_nat_ftp

###-----------------------------------------------------###
# �~�����q IP �Τ���
###-----------------------------------------------------###
echo "Set external ......"
echo

FW_IP="$IP"
FW_IP_RANGE="$NETWORK"
#FW_IFACE="eth0"

###-----------------------------------------------------###
# �]�w�������q IP �Τ���
###-----------------------------------------------------###
echo "Set internal ......"
echo

#LAN_IP="192.168.1.1"
#LAN_IP_RANGE="192.168.1.0/24"
#LAN_BCAST_ADRESS="192.168.1.255"
#LAN_IFACE="eth1"

# loopback interface
LO_IFACE="lo"
LO_IP="127.0.0.1"



###-----------------------------------------------------###
# ���} forward 
###-----------------------------------------------------###
#echo "Enable ip_forward ......"
#echo

#echo "1" > /proc/sys/net/ipv4/ip_forward


###-----------------------------------------------------###
# �M�����e���]�w
###-----------------------------------------------------###
echo "Flush fiter table ......"
echo

# Flush filter
\$IPTABLES -F
\$IPTABLES -X

echo "Flush mangle table ......"
echo
# Flush mangle
\$IPTABLES -F -t mangle
\$IPTABLES -t mangle -X


echo "Flush nat table ......"
echo
# Flush nat
\$IPTABLES -F -t nat
\$IPTABLES -t nat -X

###-----------------------------------------------------###
# �]�w filter table ���w�]�F��
###-----------------------------------------------------###
\$IPTABLES -P INPUT ACCEPT
\$IPTABLES -P OUTPUT ACCEPT
\$IPTABLES -P FORWARD ACCEPT

###-----------------------------------------------------###
# �Ұʤ�����~��}
###-----------------------------------------------------###

#\$IPTABLES -t nat -A POSTROUTING -o \$FW_IFACE -j SNAT --to-source \$FW_IP

###-----------------------------------------------------###
# �Ұʥ~���鷺����}
###-----------------------------------------------------###
# �Z�� \$FW_IP:8080 �s�u��, �h��}�� 192.168.1.3:80
#\$IPTABLES -t nat -A PREROUTING -p tcp -d \$FW_IP --dport 8080  -j DNAT --to 192.168.1.3:80

###-----------------------------------------------------###
# �ڵ��Y�@���� IP �ϥάY�@�q�D
###-----------------------------------------------------###

# �H�U�ʱ������D���s��~���D���� port 6677, �Цۦ�w�藍�P�A�� port �����ק�
# �� 192.168.1.6 �q�L
#\$IPTABLES -A FORWARD -o \$FW_IFACE -p tcp -s 192.168.1.6 --dport 6677 -j ACCEPT
# ��l�ױ�
#\$IPTABLES -A FORWARD -o \$FW_IFACE -p tcp --dport 6677 -j DROP

###-----------------------------------------------------###
# �ڵ��~�� IP �s�ܤ��� port ��
###-----------------------------------------------------###

# �H�U�ױ��~���D���s�ܤ����D�� port 6677
# �� 192.168.1.0/24 �q�L
#\$IPTABLES -A INPUT -i \$FW_IFACE -p tcp -s 192.168.1.0/24 --dport 6677 -j ACCEPT
# ��l�ױ�
#\$IPTABLES -A INPUT -i \$FW_IFACE -p tcp --dport 6677 -j DROP

# �u�����D�����ݺ��q�~��s��o�x�D���� FTP server port 21
\$IPTABLES -A INPUT -p tcp -s $NETWORK --dport 21 -j ACCEPT
\$IPTABLES -A INPUT -p tcp -s 127.0.0.1 --dport 21 -j ACCEPT
\$IPTABLES -A INPUT -p tcp --dport 21 -j DROP

# �u�����D�����ݺ��q�~��s��o�x�D���� Telnet server port 23
\$IPTABLES -A INPUT -p tcp -s $NETWORK --dport 23 -j ACCEPT
\$IPTABLES -A INPUT -p tcp -s 127.0.0.1 --dport 23 -j ACCEPT
\$IPTABLES -A INPUT -p tcp --dport 23 -j DROP

# �u�����D�����ݺ��q�~��s��o�x�D���� ssh port 22
\$IPTABLES -A INPUT -p tcp -s $NETWORK --dport 22 -j ACCEPT
\$IPTABLES -A INPUT -p tcp -s 127.0.0.1 --dport 22 -j ACCEPT
\$IPTABLES -A INPUT -p tcp --dport 22 -j DROP

# �u�����D�����ݺ��q�~��s��o�x�D���� imap port 143
\$IPTABLES -A INPUT -p tcp -s $NETWORK --dport 143 -j ACCEPT
\$IPTABLES -A INPUT -p tcp -s 127.0.0.1 --dport 143 -j ACCEPT
\$IPTABLES -A INPUT -p tcp --dport 143 -j DROP

# �u�����D�����ݺ��q�~��s��o�x�D���� imaps port 993
\$IPTABLES -A INPUT -p tcp -s $NETWORK --dport 993 -j ACCEPT
\$IPTABLES -A INPUT -p tcp -s 127.0.0.1 --dport 993 -j ACCEPT
\$IPTABLES -A INPUT -p tcp --dport 993 -j DROP

# �u�����D�����ݺ��q�~��s��o�x�D���� Samba port tcp 139,445 / udp 137,138
\$IPTABLES -A INPUT -p tcp -s $NETWORK --dport 139 -j ACCEPT
\$IPTABLES -A INPUT -p tcp -s $NETWORK --dport 445 -j ACCEPT
\$IPTABLES -A INPUT -p udp -s $NETWORK --dport 137 -j ACCEPT
\$IPTABLES -A INPUT -p udp -s $NETWORK --dport 138 -j ACCEPT
\$IPTABLES -A INPUT -p tcp -s 127.0.0.1 --dport 139 -j ACCEPT
\$IPTABLES -A INPUT -p tcp -s 127.0.0.1 --dport 445 -j ACCEPT
\$IPTABLES -A INPUT -p udp -s 127.0.0.1 --dport 137 -j ACCEPT
\$IPTABLES -A INPUT -p udp -s 127.0.0.1 --dport 138 -j ACCEPT
\$IPTABLES -A INPUT -p tcp --dport 139 -j DROP
\$IPTABLES -A INPUT -p tcp --dport 445 -j DROP
\$IPTABLES -A INPUT -p udp --dport 137 -j DROP
\$IPTABLES -A INPUT -p udp --dport 138 -j DROP

/sbin/ip6tables -F
/sbin/ip6tables -A INPUT -p tcp --dport 21 -j DROP
/sbin/ip6tables -A INPUT -p tcp --dport 22 -j DROP
/sbin/ip6tables -A INPUT -p tcp --dport 23 -j DROP
/sbin/ip6tables -A INPUT -p tcp --dport 139 -j DROP
/sbin/ip6tables -A INPUT -p tcp --dport 445 -j DROP
/sbin/ip6tables -A INPUT -p udp --dport 137 -j DROP
/sbin/ip6tables -A INPUT -p udp --dport 138 -j DROP


EOF

}

#
# �D�{����
#

# ���o�����N�� NET �M IP 
get_netip

# ���o�����B�n�s��줸�� 1 ���ƥءA��p 255.255.255.0 �� 24 bits�A
# 255.255.255.128 �� 25 bits�A255.255.255.192 �� 26 bits�C
get_mask_bits

# ���o get_mask ���Ǧ^��
MASKBITS=$?

NETWORK=$NET/$MASKBITS

# �إ� iptables �]�w��
gen_iptables
