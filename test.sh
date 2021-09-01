#!/bin/bash

function createSshKey() {
    # SSH_KEY_ID=$(vultr-cli ssh-key list |  awk -v h="/django/" '$0 ~ h{ print $1 }')
    SSH_KEY_ID=$(vultr-cli ssh-key list | eval "awk '/django/ {print \$1}'")
    
    echo $SSH_KEY_ID
}

function getID() {
    $1 | eval "awk '/django/ {print \$1}'"
}

# createSshKey

echo `getID $(vultr-cli ssh-key list)`