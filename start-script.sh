#!/bin/bash

# Github access token with read/write access to ssh keys
GH_SSH_ACCESS_TOKEN=<GH_ACCESS_TOKEN>
# SSH URL from the repository to clone
GH_SSH_URL=<GH_SSH_URL>
# Github Username
GH_USERNAME=<GH_USERNAME>
# Name of the application on Vultr
VULTR_APP_NAME=<VULTR_APP_NAME>

GH_SSH_PRIVATE_KEY=<GH_SSH_PRIVATE_KEY>


# Install git
yum -y install git

# Add http as a service to open port 80
firewall-cmd --add-service=http --permanent

# Restart firewalld for changes to take effect
firewall-cmd --reload

# Assert http service was added
firewall-cmd --list-all | grep http


# https://linuxhint.com/open-port-80-centos/
# Assert port was opened
# https://www.thegeekdiary.com/how-to-open-a-ports-in-centos-rhel-7/
# lsof -i -P |grep http

# # Public Key generated on personal machine
# REMOTE_PUBLIC_KEY="" # Matching Private Key should be stored in Github Secrets

# # Add public key to allow SSH access to this machine from Github Actions
# mkdir -p /root/.ssh
# chmod 700 /root/.ssh
# echo ssh-rsa $REMOTE_PUBLIC_KEY > /root/.ssh/authorized_keys
# chmod 600 /root/.ssh/authorized_keys

# Generate new SSH key pair for using Git
ssh-keygen \
    -t ed25519 \
    -f ~/.ssh/id_ed25519 \
    -C "sammykerridge@gmail.com" \
    -q -N ""


# Copy public key
VPS_PUBLIC_KEY=`cat ~/.ssh/id_ed25519.pub`
# Upload public key to Github
curl \
    -H "Authorization: token $GH_SSH_ACCESS_TOKEN" \
    --data '{"title":"'"Vultr VPS $VULTR_APP_NAME"'","key":"'"$VPS_PUBLIC_KEY"'"}' \
    https://api.github.com/user/keys


# Write host to config file
echo """
Host github.com-$GH_USERNAME
 HostName github.com
 User git
 IdentityFile ~/.ssh/id_ed25519
 """ >> ~/.ssh/config


ROOT_DIR="/home/docker/"
# WORK_DIR=$ROOT_DIR

# Change working directory
cd $ROOT_DIR

if [ ! -n "$(grep "^github.com " ~/.ssh/known_hosts)" ];
then 
    ssh-keyscan github.com >> ~/.ssh/known_hosts 2>/dev/null; 
fi;

git clone $GH_SSH_URL