#!/bin/bash

ZATO_VERSION=2.0.7
ZATO_ROOT_DIR=/home/foxway/opt/zato
ZATO_TARGET_DIR=$ZATO_ROOT_DIR/$ZATO_VERSION

getent passwd foxway
if [ $? -eq 0 ]
then
    echo "User foxway exists"
else
    groupadd foxway
    useradd foxway -g foxway
fi

cp -r /vagrant/zato /home/foxway/
chmod +x /home/foxway/zato/code/_install-fedora.sh
chmod +x /home/foxway/zato/code/install_dependencies.sh
chown -R foxway:foxway /home/foxway/zato
yum -y install git bzr gcc-gfortran haproxy \
    gcc-c++ git bzip2 bzip2-devel libffi libffi-devel \
    libevent-devel libyaml-devel libxml2-devel libxslt-devel \
    openssl openssl-devel postgresql-devel python-devel swig \
    unzip uuid-devel uuid

sudo su - foxway -c "mkdir -p /home/foxway/opt/zato/2.0.7"
sudo su - foxway -c "cd $ZATO_TARGET_DIR"
sudo su - foxway -c "wget https://github.com/zatosource/zato/archive/u/foxway.zip"
sudo su - foxway -c "unzip foxway.zip"
sudo su - foxway -c "mv zato-u-foxway/* $ZATO_TARGET_DIR"
sudo su - foxway -c "cd $ZATO_TARGET_DIR/code"
sudo su - foxway -c "./install.sh"
