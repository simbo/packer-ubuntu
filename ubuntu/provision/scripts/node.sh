#!/usr/bin/env bash

###
# install node.js via nvm
# =======================
###

PROVISION_NVM_PATH="${VAGRANT_HOME}/.nvm"
PROVISION_NODE_VERSION="6.0.0"
PROVISION_NPM_VERSION="3.8.8"

PROVISION_NVM_ENV_SCRIPT=$(cat <<EOL

# nvm
if ! command -v nvm; then
    export NVM_DIR=${PROVISION_NVM_PATH}
    [ -s "${PROVISION_NVM_PATH}/nvm.sh" ] && . "${PROVISION_NVM_PATH}/nvm.sh"
fi
EOL
)

echo_c "Installing nvm..."
git clone git://github.com/creationix/nvm.git $PROVISION_NVM_PATH && cd $PROVISION_NVM_PATH && git checkout `git describe --abbrev=0 --tags`

if ! sudo grep -q "# nvm" /etc/profile; then
    sudo su -c "echo \"$PROVISION_NVM_ENV_SCRIPT\" >>/etc/profile"
fi

if ! sudo grep -q "# nvm" $VAGRANT_HOME/.zshenv; then
    sudo su -c "echo \"$PROVISION_NVM_ENV_SCRIPT\" >>$VAGRANT_HOME/.zshenv"
fi

export NVM_DIR=$PROVISION_NVM_PATH
source $NVM_DIR/nvm.sh

echo_c "Installing node.js v${PROVISION_NODE_VERSION}..."

nvm install $PROVISION_NODE_VERSION
nvm alias default $PROVISION_NODE_VERSION
cd $PROVISION_NVM_PATH/versions/node
ln -sf v${PROVISION_NODE_VERSION} current

echo_c "Installing npm v${PROVISION_NPM_VERSION}..."

cd $VAGRANT_HOME
npm install -g npm@$PROVISION_NPM_VERSION
npm cache clean
npm config set cache-lock-stale 604800000
npm config set cache-min 86400
npm config set loglevel error
