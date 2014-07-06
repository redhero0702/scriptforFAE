#! /bin/bash
#
# �`�N! �o��{���u�A�Ω� C clase (�t)�H�U�����q
#
#--------------------------------------
# �ܼƭn���ŧi��~��ϥ�
shopt -s -o nounset

#
# �ŧi��
#
ListIPcmd="/sbin/ifconfig"
Hallow="/etc/hosts.allow"
Hdeny="/etc/hosts.deny"
Services="sshd vsftpd in.qpopper"
IP=
MASK=
declare -i ip4 L U c net

#
# �禡��
#

# ���o�����B�n��
get_mask() {
    MASK=$($ListIPcmd | grep 'Mask:' | grep -v '127.0.0.1' | awk '{print $4}' | awk -F: '{print $2}')
}

# ���o�D���Ҧb���q�������N��
get_netip() {
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
}


#
# �D�{����
#

get_netip

:> $Hallow
:> $Hdeny
echo "ALL: ALL" >> $Hdeny

for s in $Services
do
   echo "$s: $f3ip.$net/$MASK" >> $Hallow
done
