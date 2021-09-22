#!/bin/bash

# Github access token with read/write access to ssh keys
GH_SSH_ACCESS_TOKEN=<GH_ACCESS_TOKEN>
# SSH URL from the repository to clone
GH_SSH_URL=<GH_SSH_URL>
# Github Username
GH_USERNAME=<GH_USERNAME>
# Name of the application on Vultr
VULTR_APP_NAME=<VULTR_APP_NAME>

# Install git
yum -y install git

# Add http as a service to open port 80
firewall-cmd --add-service=http --permanent

# Restart firewalld for changes to take effect
firewall-cmd --reload

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


# Change working directory
ROOT_DIR="/home/docker/"
cd $ROOT_DIR

# Add github to known ssh hosts, this might be susceptible to a man in the middle attack
if [ ! -n "$(grep "^github.com " ~/.ssh/known_hosts)" ];
then 
    ssh-keyscan github.com >> ~/.ssh/known_hosts 2>/dev/null; 
fi;

git clone $GH_SSH_URL