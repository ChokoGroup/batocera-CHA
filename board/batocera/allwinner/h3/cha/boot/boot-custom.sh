#! /bin/bash

case "$1" in
  start)
	clear > /dev/tty0
	mount -o remount,rw /boot
	if [ -e /boot/del-boot-custom ]
	then
	  rm -f /boot/boot-custom.sh
	  sync
	  mount -o remount,ro /boot
	else
	  SHAREPART=$(/usr/bin/batocera-part share_internal)
	  if [ -n "$SHAREPART" ] && [ -e /dev/mmcblk1boot0 ]
	  then
		if [ "$(/usr/bin/batocera-part boot)" = "/dev/mmcblk0p1" ] &&  [ "$SHAREPART" = "/dev/mmcblk0p3" ]
		then
		  echo "Changing BATOCERA_DISK partition label to BATOCERA_DISK_SD" > /dev/tty0
		  e2label /dev/mmcblk0p3 BATOCERA_DISK_SD || { echo "Something went wrong renaming BATOCERA_DISK partition to BATOCERA_DISK_SD!" > /dev/tty0; sleep 4; poweroff -f; }
		  echo "Changing CHA_DISK partition label to CHA_DISK_SD" > /dev/tty0
		  e2label /dev/mmcblk0p2 CHA_DISK_SD || { echo "Something went wrong renaming CHA_DISK partition to CHA_DISK_SD!" > /dev/tty0; sleep 4; poweroff -f; }
		  echo "Changing boot partition label to CHA_BOOT_SD" > /dev/tty0
		  fatlabel /dev/mmcblk0p1 CHA_BOOT_SD || { echo "Something went wrong renaming CHA_BOOT partition to CHA_BOOT_SD!" > /dev/tty0; sleep 4; poweroff -f; }
		  sed -i 's/CHA_BOOT /CHA_BOOT_SD /' /boot/extlinux/extlinux.*
		  echo "Done with partitions labels! Rebooting..." > /dev/tty0
		fi
		touch /boot/del-boot-custom
		rm -f /boot/extlinux/extlinux.conf
		sync
		mount -o remount,ro /boot
		sleep 2
		reboot
	  else
		echo "Something is wrong with SD card or eMMC partitions order!" > /dev/tty0
		echo "This is how they are listed now:" > /dev/tty0
		lsblk -o name,mountpoint,label /dev/mmcblk??* > /dev/tty0
		echo "Remove the power cable and try again after a couple of minutes." > /dev/tty0
		poweroff
	  fi
	fi
  ;;
  *)
    exit
  ;;
esac
