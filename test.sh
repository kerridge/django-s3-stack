#!/bin/bash

function createSshKey() {
    # SSH_KEY_ID=$(vultr-cli ssh-key list |  awk -v h="/django/" '$0 ~ h{ print $1 }')
    SSH_KEY_ID=$(vultr-cli ssh-key list | eval "awk '/django/ {print \$1}'")
    
    echo $SSH_KEY_ID
    if [ -z "$SSH_KEY_ID" ]
    then
        echo "No SSH key found, creating one now..."
    else
        echo Found existing configuration, exiting now...
        exit 1
    fi
}

createSshKey