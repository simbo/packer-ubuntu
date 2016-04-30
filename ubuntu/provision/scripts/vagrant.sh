#!/usr/bin/env bash

###
# setup for vagrant
# =================
###

VAGRANT_SSH_DIR="${VAGRANT_HOME}/.ssh"

echo_c "Installing vagrant insecure key..."

mkdir $VAGRANT_SSH_DIR
wget --no-check-certificate -O authorized_keys 'https://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub'
mv authorized_keys $VAGRANT_SSH_DIR
chmod -R go-rwsx $VAGRANT_SSH_DIR

echo_c "Adding vagrant user to passwordless sudo..."

cp /etc/sudoers{,.orig}
sed -i -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers
