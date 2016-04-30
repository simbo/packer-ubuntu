#!/usr/bin/env bash

###
# install virtual box guest additions
# ===================================
###

VBOX_VERSION=$(cat $VAGRANT_HOME/.vbox_version)
VBOX_GA_ISO="${VAGRANT_HOME}/VBoxGuestAdditions_${VBOX_VERSION}.iso"
VBOX_GA_MOUNT="/tmp/virtualbox"

echo_c "Mounting and installing VirtualBox guest additions..."

mkdir $VBOX_GA_MOUNT
mount -o loop $VBOX_GA_ISO $VBOX_GA_MOUNT
sh $VBOX_GA_MOUNT/VBoxLinuxAdditions.run
umount $VBOX_GA_MOUNT
rm -rf $VBOX_GA_MOUNT
rm $VBOX_GA_ISO
