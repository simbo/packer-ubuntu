#!/usr/bin/env bash

###
# temporary fix
# =============
# https://github.com/mitchellh/vagrant/issues/7155
# https://github.com/mitchellh/vagrant/pull/7241
###

# update bootloader (grub)
sed -i /etc/default/grub \
  -e "s/GRUB_HIDDEN_TIMEOUT=[0-9]\+/GRUB_HIDDEN_TIMEOUT=1/g" \
  -e "s/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet\"/GRUB_CMDLINE_LINUX_DEFAULT=\"net.ifnames=0 quiet\"/g"
update-grub

# update network interfaces
sed /etc/network/interfaces -i -e 's/\enp0s3/eth0/g'
echo "auto eth1" >> /etc/network/interfaces
echo "iface eth1 inet manual" >> /etc/network/interfaces
echo "auto eth2" >> /etc/network/interfaces
echo "iface eth2 inet manual" >> /etc/network/interfaces
echo "auto eth3" >> /etc/network/interfaces
echo "iface eth3 inet manual" >> /etc/network/interfaces
