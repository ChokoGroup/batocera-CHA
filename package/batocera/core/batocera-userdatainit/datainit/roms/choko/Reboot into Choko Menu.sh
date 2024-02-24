#!/bin/sh
mount -o remount,rw /boot
rm -f /boot/extlinux/extlinux.conf
mount -o remount,ro /boot
touch /tmp/restart.please
reboot
