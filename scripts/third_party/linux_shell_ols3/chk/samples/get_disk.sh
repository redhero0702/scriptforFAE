#! /bin/bash

# �ܼƭn���ŧi��~��ϥ�
shopt -s -o nounset

while read x x x m
do
    case "$m" in
      hd?)
        Media=$(cat /proc/ide/$m/media)
        if [ "$Media" = "disk" ] ; then
          echo "�Ϻо�: $m, ����: $(cat /proc/ide/$m/model)"
        fi
        ;;
      sd?)
        M=$(scsi_info /dev/$m | grep MODEL)
        M=${M#*\"}
        M=${M%\"*}
        echo "�Ϻо�: $m, ����: $M"
        ;;
      *) 
        ;;
    esac
done < /proc/partitions
