#! /bin/bash

case "$1" in
  start)
    clear > /dev/tty0
    if [ -e /boot/del-boot-custom ]
    then
      mount -o remount,rw /boot
      rm -f /boot/boot-custom.sh /boot/del-boot-custom
      sync
      mount -o remount,ro /boot
    else
      BOOTPART="$(/usr/bin/batocera-part boot)"
      SHAREPART="$(/usr/bin/batocera-part share_internal)"
      if [ -n "$BOOTPART" ] && [ -n "$SHAREPART" ] && [ "${BOOTPART%p?}" = "${SHAREPART%p?}" ]
      then
        mount -o remount,rw /boot
        # If there are two, SD card is present
        if [ "$(ls -1 /dev/mmcblk? | wc -l)" = "2" ]
        then
          echo "Changing BATOCERA_DISK partition label to BATOCERA_DISK_SD" > /dev/tty0
          e2label "$SHAREPART" BATOCERA_DISK_SD || { echo "Error renaming BATOCERA_DISK partition to BATOCERA_DISK_SD!" > /dev/tty0; sleep 5; poweroff -f; }
          echo "Changing CHA_DISK partition label to CHA_DISK_SD" > /dev/tty0
          e2label "${BOOTPART%?}2" CHA_DISK_SD || { echo "Error renaming CHA_DISK partition to CHA_DISK_SD!" > /dev/tty0; sleep 5; poweroff -f; }
          echo "Changing boot partition label to CHA_BOOT_SD" > /dev/tty0
          fatlabel "$BOOTPART" CHA_BOOT_SD || { echo "Error renaming CHA_BOOT partition to CHA_BOOT_SD!" > /dev/tty0; sleep 5; poweroff -f; }
          sed -i 's/CHA_BOOT /CHA_BOOT_SD /' /boot/extlinux/extlinux.*
        else
          echo "Changing BATOCERA_DISK partition label to BATOCERA_DISK_MM" > /dev/tty0
          e2label "$SHAREPART" BATOCERA_DISK_MM || { echo "Error renaming BATOCERA_DISK partition to BATOCERA_DISK_MM!" > /dev/tty0; sleep 5; poweroff -f; }
          echo "Changing CHA_DISK partition label to CHA_DISK_MM" > /dev/tty0
          e2label "${BOOTPART%?}2" CHA_DISK_MM || { echo "Error renaming CHA_DISK partition to CHA_DISK_MM!" > /dev/tty0; sleep 5; poweroff -f; }
          echo "Changing boot partition label to CHA_BOOT_MM" > /dev/tty0
          fatlabel "$BOOTPART" CHA_BOOT_MM || { echo "Error renaming CHA_BOOT partition to CHA_BOOT_MM!" > /dev/tty0; sleep 5; poweroff -f; }
          sed -i 's/CHA_BOOT /CHA_BOOT_MM /' /boot/extlinux/extlinux.*
        fi
        echo -e "Done renaming partitions labels.\nRebooting..." > /dev/tty0
        touch /boot/del-boot-custom
        rm -f /boot/extlinux/extlinux.conf
        sync
        mount -o remount,ro /boot
        sleep 2
        reboot
      else
        echo -e "Something is wrong with boot or Batocera partition!\nDEBUG INFO:\nBOOTPART=\"$BOOTPART\"   (/boot)\nSHAREPART=\"$SHAREPART\"   (/userdata)" > /dev/tty0
        lsblk -o name,mountpoint,label /dev/mmcblk??* > /dev/tty0
        echo -e "\nRemove the power cable and try again after a couple of minutes." > /dev/tty0
        sleep 10
        poweroff
      fi
    fi
  ;;
  *)
    exit 0
  ;;
esac
