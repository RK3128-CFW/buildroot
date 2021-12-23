#!/bin/sh

MKIMAGE=$HOST_DIR/bin/mkimage
BOARD_DIR="$(dirname $0)"
UBOOT_DIR=output/build/uboot-wx8
IMAGES_DIR=output/images
TARGET_DIR=output/target

$UBOOT_DIR/tools/mkimage -n rk3128 -T rksd -d $IMAGES_DIR/rkbin/bin/rk31/rk3128_ddr_300MHz_v2.12.bin $IMAGES_DIR/idbloader.img
cat $IMAGES_DIR/rkbin/bin/rk31/rk3128x_miniloader_v2.57.bin >> $IMAGES_DIR/idbloader.img

# Generate uboot.img
$UBOOT_DIR/tools/loaderimage --pack --uboot $UBOOT_DIR/u-boot-dtb.bin $IMAGES_DIR/uboot.img --size 1024 4
  
# Generate trust.img
$UBOOT_DIR/tools/loaderimage --pack --trustos $IMAGES_DIR/rkbin/bin/rk31/rk3126_tee_ta_v2.01.bin $IMAGES_DIR/trust.img --size 1024 4

# Populate the boot partition
board/rk3128-cfw/wx8/ps5000/create-boot-script.sh $BOARD_DIR $IMAGES_DIR 
install -m 0644 -D $BOARD_DIR/boot/extlinux.conf $TARGET_DIR/boot/extlinux/extlinux.conf
install -m 0644 -D board/rk3128-cfw/common/wpa-supplicant.conf $IMAGES_DIR/wpa-supplicant.conf
install -m 0644 -D ../package/batocera/core/batocera-system/batocera-boot.conf $IMAGES_DIR/batocera-boot.conf

# Create overlay for 
if [ ! -d $TARGET_DIR/overlay ]; then
	mkdir $TARGET_DIR/overlay
fi


