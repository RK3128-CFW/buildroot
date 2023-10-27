#!/bin/sh
BOARD_DIR="$(dirname $0)"

cp $BOARD_DIR/batocera-boot.conf $BINARIES_DIR/batocera-boot.conf

# We don't really need this but the batocera image script requires it
cp -r $BOARD_DIR/tools $BINARIES_DIR/

# Create empty swap partition
truncate -s 512M $BINARIES_DIR/swap.img
chmod 0600 $BINARIES_DIR/swap.img
mkswap $BINARIES_DIR/swap.img

