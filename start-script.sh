# !/bin/bash

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

# Generate new SSH key pair
# Update config with
# mkdir -p /root/.ssh
# chmod 700 /root/.ssh
# echo ssh-rsa AA... youremail@example.com > /root/.ssh/authorized_keys
# chmod 600 /root/.ssh/authorized_keys