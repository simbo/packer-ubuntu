#!/usr/bin/env bash

###
# cleanup
# =======
###

echo_c "Removing all linux kernels except the current one..."

dpkg --list | awk '{ print $2 }' | grep 'linux-image-3.*-generic' | grep -v $(uname -r) | xargs apt-get -y purge

echo_c "Removing linux source..."

dpkg --list | awk '{ print $2 }' | grep linux-source | xargs apt-get -y purge

echo_c "Removing X11 libraries..."

apt-get -y -qq purge libx11-data xauth libxmuu1 libxcb1 libx11-6 libxext6

echo_c "Removing obsolete networking components..."

apt-get -y -qq purge ppp pppconfig pppoeconf

echo_c "Removing other oddities..."

apt-get -y -qq purge popularity-contest installation-report landscape-common wireless-tools wpasupplicant

echo_c "Let vagrant user own everything within its home..."

chown -R $VAGRANT_USER:$VAGRANT_USER $VAGRANT_HOME/.?*

echo_c "Cleaning up udev rules..."

# Make sure udev does not block our network - http://6.ptmc.org/?p=164
rm -rf /dev/.udev/
rm /lib/udev/rules.d/75-persistent-net-generator.rules

echo_c "Cleaning up leftover dhcp leases..."

if [ -d "/var/lib/dhcp" ]; then
    rm /var/lib/dhcp/*
fi

echo_c "Cleaning up tmp..."

rm -rf /tmp/*

echo_c "Cleaning up apt..."

apt-get -y -qq install deborphan
while [ -n "$(deborphan --guess-all --libdevel)" ]; do
    deborphan --guess-all --libdevel | xargs apt-get -y purge
done
apt-get -y -qq autoremove --purge
apt-get -y -qq purge deborphan dialog
apt-get -y -qq autoclean
apt-get -y -qq clean
aptitude -y clean

echo_c "Removing APT files..."
find /var/lib/apt -type f | xargs rm -f

echo_c "Removing anything in /usr/src..."

rm -rf /usr/src/*

echo_c "Removing caches..."

find /var/cache -type f -exec rm -rf {} \;

echo_c "Cleaning bash history..."

unset HISTFILE
[ -f /root/.bash_history ] && rm /root/.bash_history
[ -f $VAGRANT_HOME/.bash_history ] && rm $VAGRANT_HOME/.bash_history

echo_c "Cleaning logs..."

find /var/log -type f | while read f; do echo -ne '' > $f; done

echo_c "Cleaning last login info..."
>/var/log/lastlog
>/var/log/wtmp
>/var/log/btmp

echo_c "Whiteout root..."

count=`df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}'`
let count--
dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count
rm /tmp/whitespace

echo_c "Whiteout boot..."

count=`df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}'`
let count--
dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count;
rm /boot/whitespace

echo_c "Whiteout swap..."

swappart=`cat /proc/swaps | tail -n1 | awk -F ' ' '{print $1}'`
swapoff $swappart
dd if=/dev/zero of=$swappart
mkswap -f $swappart
swapon $swappart

echo_c "Zero out the free space..."

dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Make sure we wait until all the data is written to disk, otherwise
# Packer might quit too early before the large files are deleted
sync
