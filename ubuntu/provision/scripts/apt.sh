#!/usr/bin/env bash

###
# update and install packages via apt
# ===================================
###

echo_c "Add custom sources..."

apt-get -y -qq install software-properties-common
add-apt-repository -y ppa:git-core/ppa

echo_c "Updating apt sources..."

apt-get -y -qq update

echo_c "Upgrading packages..."

apt-get -y -qq -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade

echo_c "Install Packages..."

apt-get -y -qq install curl vim mc htop iotop iftop tree git zsh
