#!/bin/bash

# ENV
# VULTR_API_KEY

function createSshKey() {
    SSH_KEY_ID=$(vultr-cli ssh-key list  | eval "awk '/$VULTR_APP_NAME/ {print \$1}'")

    if [ -z "$SSH_KEY_ID" ]
    then
        echo "No SSH key found, creating one now..."

        ssh-keygen \
            -t ed25519 \
            -f ~/.ssh/id_ed25519 \
            -C "$SSH_EMAIL_ADDRESS" \
            -q -N ""

        PUBLIC_KEY="$(cat ~/.ssh/id_ed25519.pub)"
        PRIVATE_KEY="$(cat ~/.ssh/id_ed25519)"

        # Write key to file for future steps to use
        echo $PRIVATE_KEY >> key.txt

        vultr-cli ssh-key create \
            --key "$PUBLIC_KEY" \
            --name "$VULTR_APP_NAME"
        
        SSH_KEY_ID=$(vultr-cli ssh-key list  | eval "awk '/$VULTR_APP_NAME/ {print \$1}'")
            
        vultr-cli ssh-key list
    else
        echo Found existing configuration, skipping create...
    fi

    echo "SSH_KEY_ID=$SSH_KEY_ID"  >> $GITHUB_ENV
}

function createStartupScript() {
    STARTUP_SCRIPT_ID=$(vultr-cli script list  | eval "awk '/$VULTR_APP_NAME/ {print \$1}'")

    if [ -z "$STARTUP_SCRIPT_ID" ]
    then
        echo "No startup script found, creating one now..."

        # base64 encode our script
        SCRIPT=$(base64 -w0 start-script.sh)

        vultr-cli script create \
            --name $VULTR_APP_NAME \
            --type boot \
            --script $SCRIPT

        STARTUP_SCRIPT_ID=$(vultr-cli script list  | eval "awk '/$VULTR_APP_NAME/ {print \$1}'")
    else
        echo Found existing configuration, skipping create...
    fi

    echo "STARTUP_SCRIPT_ID=$STARTUP_SCRIPT_ID"  >> $GITHUB_ENV
}

function createInstance() {
    if [ -z "$(vultr-cli instance list | grep $VULTR_APP_NAME)" ]
    then
        SSH_KEYS=("$SSH_KEY_ID")
    
        vultr-cli instance create \
            --region $VULTR_VPS_REGION \
            --plan $VULTR_VPS_PLAN \
            --app $VULTR_VPS_APP_ID \
            --label $VULTR_APP_NAME \
            --script-id "$STARTUP_SCRIPT_ID" \
            --ssh-keys $SSH_KEYS \
            --ipv6 false

        # vultr-cli instance list
        INSTANCE_ID=$(vultr-cli instance list  | eval "awk '/$VULTR_APP_NAME/ {print \$1}'")
        vultr-cli instance get $INSTANCE_ID
    else
        echo "Found existing instance with matching name, cancelling deployment..."
        exit 1
    fi
}

function getInstanceIpAddress() {
    echo yo
}

while [ $# -gt 0 ]; do
    case $1 in
        "--ssh") createSshKey; shift; ;;
        "--start-script") createStartupScript; shift; ;;
        "--create-instance") createInstance; shift; ;;
        *) shift ;;
    esac
done