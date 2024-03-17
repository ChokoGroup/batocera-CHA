#!/bin/sh
mount -o remount,rw /boot
cp /boot/extlinux/extlinux.batocera.720p.conf /boot/extlinux/extlinux.conf
sed -i '/system.es.atstartup/d' /boot/batocera-boot.conf
mount -o remount,ro /boot
touch /tmp/restart.please
emulationstation-standalone --stop-rebooting
killall emulationstation 2>/dev/null
reboot
