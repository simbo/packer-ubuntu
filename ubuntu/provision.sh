#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

PROVISION_DIR="/tmp/provision"
PROVISION_SCRIPTS="${PROVISION_DIR}/scripts"
PROVISION_FILES="${PROVISION_DIR}/files"
VAGRANT_HOME="/home/${VAGRANT_USER}"

# highlight step messages
function echo_c() {
    echo -e "\e[35m==> ${1}\e[0m"
}

# run provision steps
source $PROVISION_SCRIPTS/apt.sh
source $PROVISION_SCRIPTS/vagrant.sh
source $PROVISION_SCRIPTS/vbox-guest-additions.sh
source $PROVISION_SCRIPTS/zsh.sh
source $PROVISION_SCRIPTS/node.sh
source $PROVISION_SCRIPTS/customize.sh
source $PROVISION_SCRIPTS/cleanup.sh

# cleanup provision files
rm -rf $PROVISION_DIR
