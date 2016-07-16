packer-ubuntu
===============

  > Packer template for [simbo/ubuntu](https://atlas.hashicorp.com/simbo/boxes/ubuntu).

---

<!-- MarkdownTOC -->

- [About](#about)
  - [Box Info](#box-info)
- [Building locally](#building-locally)
- [Releasing](#releasing)

<!-- /MarkdownTOC -->

---


## About

This is a [packer](https://packer.io/) template for the vagrant box 
[simbo/ubuntu](https://atlas.hashicorp.com/simbo/boxes/ubuntu).


### Box Info

Usage: `vagrant init simbo/ubuntu`

Available providers: `virtualbox` (~ 431 MB)

Current version: **Ubuntu *“Xenial Xerus”* 16.04 LTS Server amd64**

Using english locales by default and supporting german locales. Set up with 
german keyboard config, german apt-sources and using Europe/Berlin as default 
timezone.

Default vagrant config with vagrant insecure key and passwordless sudo.

Installed software:
  - **git** (via ppa:git-core/ppa)
  - **zsh** as default shell with **oh-my-zsh**
  - **node.js** v6.3.0 (via **nvm**) with **npm** v3.10.5
  - **VirtualBox Guest Additions** v5.0.20
  - **openssh-server**
  - **build-essential**
  - **dkms**
  - **nfs-common**
  - **curl**
  - **vim**
  - **nano**
  - **mc**
  - **htop**
  - **iotop**
  - **iftop**
  - **tree**


## Building locally

Requirements:
  [packer](https://packer.io/),
  [vagrant](https://www.vagrantup.com/),
  [VirtualBox](https://www.virtualbox.org/)

Temporarily remove the `atlas` post-processor section from the template to 
avoid publishing when building and testing locally. (Still waiting for a cli 
flag to [disable a post-processor](https://github.com/mitchellh/packer/issues/2679)…)

You can place a distribution image for installation at `iso/ubuntu.iso`.

``` sh
# inpect template properties
packer inspect ubuntu.json

# validate template
packer validate ubuntu.json

# build template
packer build [-force] [-debug] ubuntu.json

# test vagrant box
vagrant box add <boxname> build/ubuntu.box
vagrant init <boxname>
vagrant up

# remove/cleanup vagrant test
vagrant halt
vagrant destroy
vagrant box remove <boxname>
rm -rf .vagrant Vagrantfile

# remove built and temporary files
rm -rf build output-* packer_cache
```


## Releasing

The master branch of this repo is automatically tested by travis-ci using packer
validation test. Tagged commits are pushed to atlas where successful builds are 
published.

