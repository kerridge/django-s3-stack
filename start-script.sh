# !/bin/sh

# Install git
yum install git

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

# Public Key generated on personal machine
REMOTE_PUBLIC_KEY="" # Matching Private Key should be stored in Github Secrets

# Add public key to allow SSH access to this machine from Github Actions
mkdir -p /root/.ssh
chmod 700 /root/.ssh
echo ssh-rsa $REMOTE_PUBLIC_KEY > /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

# Generate new SSH key pair for using Git
ssh-keygen -t ed25519 -C "example@mail.com" -q -N ""

# Copy public key
HOST_PUBLIC_KEY=`cat ~/.ssh/id_ed25519.pub`
# Upload public key to Github
curl \
    -H "Authorization: token YOUR_TOKEN_HERE" \
    --data '{"title":"Vultr VPS","key":"'"$HOST_PUBLIC_KEY"'"}' \
    https://api.github.com/user/keys


GITHUB_USERNAME=""
# Write host to config file
echo """
Host github.com-$GITHUB_USERNAME
 HostName github.com
 User git
 IdentityFile ~/.ssh/id_ed25519
 """ >> ~/.ssh/config


ROOT_DIR="/home/docker/"
# WORK_DIR=$ROOT_DIR

# SSH URL for your repository
GITHUB_SSH_URL=""

# Change working directory
cd $ROOT_DIR

git clone $GITHUB_SSH_URL