#!/bin/sh
mount -o remount,rw /boot
cp /boot/extlinux/extlinux.batocera.720p.conf /boot/extlinux/extlinux.conf
/usr/bin/batocera-settings-set -f /boot/batocera-boot.conf system.es.atstartup 0
mount -o remount,ro /boot
touch /tmp/restart.please
reboot
