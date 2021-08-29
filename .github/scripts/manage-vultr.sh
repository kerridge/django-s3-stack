#!/bin/bash

# ENV
# VULTR_API_KEY

function createSshKey() {
    SSH_KEY_ID=$(vultr-cli ssh-key list |  awk "/$VULTR_APP_NAME/ { print $1 }")

    if [ -z "$SSH_KEY_ID" ]
    then
        ssh-keygen \
            -t ed25519 \
            -f ~/.ssh/id_ed25519 \
            -C "$SSH_EMAIL_ADDRESS" \
            -q -N ""

        PUBLIC_KEY="$(cat ~/.ssh/id_ed25519.pub)"
        PRIVATE_KEY="$(cat ~/.ssh/id_ed25519)"

        # Set as environment variables
        echo 'PRIVATE_KEY<<EOF'  >> $GITHUB_ENV
        echo $PRIVATE_KEY >> $GITHUB_ENV
        echo 'EOF' >> $GITHUB_ENV


        vultr-cli ssh-key create \
            --key "$PUBLIC_KEY" \
            --name "$VULTR_APP_NAME"
        
        SSH_KEY_ID=$(vultr-cli ssh-key list |  awk "/$VULTR_APP_NAME/ { print $1 }")
        
        echo "SSH_KEY_ID=$SSH_KEY_ID"  >> $GITHUB_ENV
        
        vultr-cli ssh-key list
    else
        exit 1
    fi
}

function createStartupScript() {
    STARTUP_SCRIPT_ID=$(vultr-cli script list |  awk "/$VULTR_APP_NAME/ { print $1 }")

    if [ -z "$STARTUP_SCRIPT_ID" ]
    then
        # base64 encode our script
        SCRIPT=$(base64 -w0 start-script.sh)

        vultr-cli script create \
            --name $VULTR_APP_NAME \
            --type boot \
            --script $SCRIPT

        STARTUP_SCRIPT_ID=$(vultr-cli script list |  awk "/$VULTR_APP_NAME/ { print $1 }")
        
        echo "STARTUP_SCRIPT_ID=$STARTUP_SCRIPT_ID"  >> $GITHUB_ENV

        vultr-cli script list
    else
        exit 1
    fi
}

function createInstance() {
    if [ -z "$(vultr-cli instance list | grep $VULTR_APP_NAME)" ]
    then
        vultr-cli instance list
    fi
}

function getInstanceIpAddress() {
    echo yo
}

while [ $# -gt 0 ]; do
    case $1 in
        "--ssh") createSshKey; shift; ;;
        *) shift ;;
    esac
done