#!/usr/bin/env bash

###
# setup zsh
# =========
###

echo_c "Setting zsh as default shell..."

chsh -s $(which zsh) $VAGRANT_USER

echo_c "Installing oh-my-zsh..."

git clone git://github.com/robbyrussell/oh-my-zsh.git $VAGRANT_HOME/.oh-my-zsh

echo_c "Installing zsh-git-prompt..."

git clone git://github.com/olivierverdier/zsh-git-prompt.git $VAGRANT_HOME/.zsh-git-prompt

echo_c "Copying zsh config..."

cp $PROVISION_FILES/.zsh* $VAGRANT_HOME/.
