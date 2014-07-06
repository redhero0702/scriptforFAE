#! /bin/bash

# �ܼƭn���ŧi��~��ϥ�
shopt -s -o nounset

#
# �ŧi��
#

# �ƥ����A�����D���W�١C�N�������;��s�@���]�w�ɪ��x�s�ؿ��C
server_name=${1:?'�д��ѳƥ����A�D�����W�١A��p�G bksvr'}

# client �ݭn�ƥ��X�h���ؿ��A�ХΪťզr���j�}
bk_dirs="/home /etc /var/lib/mysql"
# client �ݥD���W��
mach="mch1"

# �ƥ����A��������D���W�٩� IP
server_addr="bk.sample.edu.tw"
# �b��
act="$mach"_backup
# �K�X
pwd="thisispwd"
# Server �ݳƥ��x�s��
BK_SAVE="/bk"

# rsync ���Ѽ�
para="-avHS --numeric-ids"

# client �ݭY�����s�b���ɮסA��R�h�ƥ��D���W�������ɮסC
# �Y�z�n�ϥγo�˪��\��A�Ч�γo�ӰѼ�
#para="-avHS --numeric-ids --delete"

#----------------------------------------------
# �ƥ����A�����D�n�]�w��
server_conf="$server_name/svr/rsyncd.conf"
# �ƥ����A�������v�b���K�X��
server_pwdfile="$server_name/svr/rsyncd.secrets"

# �� client �ݰ��檺�ƥ� script
client_script="$server_name/clt/bk-$mach-to-$server_name.sh"
# client �ݻݥΨ쪺�K�X��
client_pwdfile="$server_name/clt/rsyncd.secrets"
# �ƥ� client �ݪ��u�@�Ƶ{��
client_cron="$server_name/clt/cron.tab"
# �w�˥Ϊ� script
installer="$server_name/install.sh"


#
# �禡��
#

# �H client �ݥD���W�٬��s�ɪ��ؿ�
cr_client_dir() {
   if [ -f "$server_name" ]; then
      echo "$server_name �o���ɮפw�s�b�A�Ч�W�β��}��."
      exit 1
   fi
   
   if [ ! -d "$server_name" ]; then
      mkdir -p "$server_name/svr"
      mkdir -p "$server_name/clt"
   fi
}

# �إ� client �ݻݥΨ쪺�K�X��
cr_client_pwdfile() {
   cat <<EOF > $client_pwdfile
$pwd
EOF

   chmod 600 $client_pwdfile
}

# �إ� clinet �ݥΪ��ƥ� script
cr_run_script() {
   cat <<EOF > $client_script
#! /bin/bash

RSYNC="/usr/bin/rsync"

EOF

# �إ߳ƥ����O�C
   for dir in $bk_dirs
   do
      cat <<EOF >> $client_script
\$RSYNC $para --password-file=/root/rsyncd.secrets $dir $act@$server_addr::$mach
EOF

done

   chmod +x $client_script
}

# �إ� client �ݪ��u�@�Ƶ{
cr_crontab() {
   cat <<EOF > $client_cron
0 1 * * * /root/bk-$mach-to-$server_name.sh
EOF
}


# �إ߳ƥ����A�����D�n�]�w��
cr_rsync_conf() {
   cat <<EOF > $server_conf
log file = /var/log/rsyncd.log

[$mach]
   path = $BK_SAVE/$act
   auth users = $act
   uid = root
   gid = root
   secrets file = /etc/rsyncd.secrets
   read only = no
EOF
}

# �إ߳ƥ����A�����K�X��
cr_rsync_pwdfile() {
   cat <<EOF > $server_pwdfile
$act:$pwd
EOF

   chmod 600 $server_pwdfile
}

# �إ� server �ݪ��w����
cr_installer() {
   cat <<EOF > $installer
#! /bin/bash

target=\${1:?"�д��ѭn�w�˪���H�C�ϥΪk�G \$0 server �� \$0 client"}

install_to_server() {
   cp -pf ../$server_conf /etc
   cp -pf ../$server_pwdfile /etc
   if [ ! -d "$BK_SAVE/${mach}_backup" ]; then
      mkdir -p "$BK_SAVE/${mach}_backup"
   fi
}

install_to_client() {
   cp -pf ../$client_script /root
   cp -pf ../$client_pwdfile /root
   cp -pf ../$client_cron /root
}

usage() {
   echo "�д��ѭn�w�˪���H�C�ϥΪk�G \$0 server �� \$0 client"
   exit 1
}

#
# �D�{����
#
case \$target in
   server)
     install_to_server
     ;;
   client)
     install_to_client
     ;;
   *)
     usage
     ;;
esac

EOF

   chmod +x $installer
}

tar_it() {
   tar cvzf $server_name.tgz $server_name
}

#
# �D�{����
#

cr_client_dir
cr_client_pwdfile
cr_crontab
cr_run_script

cr_rsync_conf
cr_rsync_pwdfile
cr_installer

tar_it
