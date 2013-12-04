#!/bin/bash
apt-get -y update
apt-get -y upgrade

apt-get -y update
apt-get -y install curl
apt-get -y install vim-nox
apt-get -y install git-core
apt-get clean
