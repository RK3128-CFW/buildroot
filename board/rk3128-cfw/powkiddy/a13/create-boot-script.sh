#!/bin/bash

# BOARD_DIR = board specific dir
# BINARIES_DIR = images dir

BOARD_DIR=$1
BINARIES_DIR=$2

mkdir -p "${BINARIES_DIR}/boot"     || exit 1
mkdir -p "${BINARIES_DIR}/extlinux" || exit 1

cp "${BINARIES_DIR}/zImage"             "${BINARIES_DIR}/boot/linux"           || exit 1
cp "${BINARIES_DIR}/initrd.gz"          "${BINARIES_DIR}/boot/"                || exit 1
cp "${BINARIES_DIR}/rootfs.squashfs"    "${BINARIES_DIR}/boot/batocera"        || exit 1

cp "${BINARIES_DIR}/rk3128-powkiddy-a13-rev-ab.dtb"     "${BINARIES_DIR}/boot/"     || exit 1
cp "${BOARD_DIR}/boot/extlinux.conf"    "${BINARIES_DIR}/extlinux/" || exit 1
cp "${BOARD_DIR}/batocera-boot.conf"    "${BINARIES_DIR}/"          || exit 1

exit 0
