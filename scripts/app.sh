#!/bin/bash

APP_USER=app
APP_HOME=/home/$APP_USER

## create the app user (if not already present)
if ! id -u $APP_USER >/dev/null 2>&1; then
    groupadd $APP_USER
    useradd $APP_USER -g $APP_USER -G sudo -d $APP_HOME \
        -s /bin/bash --create-home
    echo "${APP_USER}:${APP_USER}" | chpasswd
fi

## add the app user to the docker group
usermod -a -G docker $APP_USER

## clone the app and add the `dotenv` file
cd $APP_HOME
sudo -u $APP_USER git clone $DOCKER_APP app
sudo -u $APP_USER mv /_env app/.env

# build the docker container for the app
cd $APP_HOME/app
sudo -u $APP_USER docker build -t app .

## create a upstart script to start the app
(
cat << 'EOF'
description "app container"
author "Markus Hubig <mhubig@imko.de>"
start on filesystem and started docker
stop on runlevel [!2345]
respawn
script
  # Wait for docker to finish starting up first.
  FILE=/var/run/docker.sock
  while [ ! -e $FILE ] ; do
    inotifywait -t 2 -e create $(dirname $FILE)
  done
  /usr/bin/docker start -a app
end script
EOF
) > /etc/init/app.conf
