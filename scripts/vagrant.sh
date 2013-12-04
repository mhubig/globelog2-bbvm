#!/bin/bash

VAGRANT_USER=vagrant
VAGRANT_HOME=/home/$VAGRANT_USER
VAGRANT_KEY=/tmp/ssh_key.pub

# Save the day
date > /etc/vagrant_box_build_time

# Create Vagrant user (if not already present)
if ! id -u $VAGRANT_USER >/dev/null 2>&1; then
    groupadd $VAGRANT_USER
    useradd $VAGRANT_USER -g $VAGRANT_USER -G sudo -d $VAGRANT_HOME \
        -s /bin/bash --create-home
    echo "${VAGRANT_USER}:${VAGRANT_USER}" | chpasswd
fi

# Set up sudo
echo "${VAGRANT_USER}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

# Install vagrant keys
mkdir $VAGRANT_HOME/.ssh
chmod 700 $VAGRANT_HOME/.ssh
cd $VAGRANT_HOME/.ssh
cat $VAGRANT_KEY > authorized_keys
chmod 600 $VAGRANT_HOME/.ssh/authorized_keys
chown -R $VAGRANT_USER:$VAGRANT_USER $VAGRANT_HOME/.ssh

# Install NFS for Vagrant
apt-get install -y nfs-common