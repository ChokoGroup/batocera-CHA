#!/bin/bash

# HOST_DIR = host dir
# BOARD_DIR = board specific dir
# BUILD_DIR = base dir/build
# BINARIES_DIR = images dir
# TARGET_DIR = target dir
# BATOCERA_BINARIES_DIR = batocera binaries sub directory

HOST_DIR=$1
BOARD_DIR=$2
BUILD_DIR=$3
BINARIES_DIR=$4
TARGET_DIR=$5
BATOCERA_BINARIES_DIR=$6

mkdir -p "${BATOCERA_BINARIES_DIR}/boot/boot"     || exit 1
mkdir -p "${BATOCERA_BINARIES_DIR}/boot/extlinux" || exit 1

cp "${BINARIES_DIR}/zImage"           "${BATOCERA_BINARIES_DIR}/boot/boot/linux"           || exit 1
cp "${BINARIES_DIR}/initrd.lz4"       "${BATOCERA_BINARIES_DIR}/boot/boot/initrd.lz4"       || exit 1
cp "${BINARIES_DIR}/rootfs.squashfs" "${BATOCERA_BINARIES_DIR}/boot/boot/batocera.update" || exit 1

cp "${BINARIES_DIR}/sun8i-h3-libretech-all-h3-cc.dtb" "${BATOCERA_BINARIES_DIR}/boot/boot/capcom-home-arcade.dtb"     || exit 1
cp -r "${BOARD_DIR}/boot" "${BATOCERA_BINARIES_DIR}"/ || exit 1

if ! test -e "${BUILD_DIR}/cha_disk_partition/cha_disk.ext4"
then
	mkdir -p "${BUILD_DIR}/cha_disk_partition" || exit 1
	curl -L https://github.com/ChokoGroup/batocera.linux/releases/download/cha_disk/cha_disk.zip -o "${BUILD_DIR}/cha_disk_partition/cha_disk.zip" || exit 1
	unzip "${BUILD_DIR}/cha_disk_partition/cha_disk.zip" -d "${BUILD_DIR}/cha_disk_partition" || exit 1
	rm -f "${BUILD_DIR}/cha_disk_partition/cha_disk.zip"
fi

exit 0
