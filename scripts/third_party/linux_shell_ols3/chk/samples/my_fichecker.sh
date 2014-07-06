#! /bin/bash

# �ܼƭn���ŧi��~��ϥ�
shopt -s -o nounset

#
# �ŧi��
#

# �إߤ��
Date=$(date +'%Y%m%d%H%M%S')

# �n�[�J�ˮ֪��ؿ��A������|�B�H�ťչj�}
Dirs="/bin /sbin /usr/bin /usr/sbin /lib /usr/local/sbin /usr/local/bin /usr/local/lib /usr/X11R6/bin /usr/X11R6/lib"

# �Ȧs��
tmpFile=$(mktemp)

# �ɮ� checksum ���x�s��
FP="/root/fp.$Date.chksum"

# �ϥέ��@�� checksum �u��
Checker="/usr/bin/md5sum"
# Checker="/usr/bin/sha1sum"

Find="/usr/bin/find"

#
# �禡��
#

# ���˭n�ˮ֪��ؿ��A�إ��ɮצC��
scan_files() {
   local f
   for f in $Dirs
   do
      $Find $f -type f >> $tmpFile
   done
}

# Ū���ɮצC��A�إߦU���ɮת� checksum �ȦC��
cr_checksum_list() {
   local f
   if [ -f $tmpFile ]; then
      for f in $(cat $tmpFile);
          do $Checker $f >> $FP
      done
   fi
}

# �M���Ȧs��
rmTMP() {
   [ -f $tmpFile ] && rm -f $tmpFile
}

#
# �D�{����
#

# �����ɮצC��
scan_files

# �إ��ɮת� checksum ��
cr_checksum_list

# �M�z�Ȧs��
rmTMP
