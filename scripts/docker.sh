#!/bin/bash

## enable memory and swap accounting
sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/' /etc/default/grub
update-grub

## add docker group and add vagrant to it
sudo groupadd docker
sudo usermod -a -G docker vagrant

## add the docker gpg key
curl https://get.docker.io/gpg | apt-key add -

## add the Docker repository to your apt sources list.
echo deb https://get.docker.io/ubuntu docker main > \
    /etc/apt/sources.list.d/docker.list
apt-get update

## install docker
apt-get install -y lxc-docker
