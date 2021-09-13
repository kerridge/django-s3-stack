#!/bin/bash

# read -r -d '' VALUE << EOM
# -----BEGIN OPENSSH PRIVATE KEY-----
# b3BlbnNzaC1rZXktdjEAAASABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
# QyNTUxOQDHDGDjI2+jKVjLb5babO5jMh1Ff6sQ/2v/fj5CNq24nomziQAAAKAQ0OJhENDi
# YQAAAAtzc2gtZWQyNTUxOQAAACDjI2+hdyfifniqfwbiMh1Ff6sQ/2v/6k5CNq24nomziQ
# AAAEBX/KwQAsVZHPe18Vq5pyZJzigiS3HfPUK8F4MYYT0pZ+Mjb6MpWMtvltps7mMyHUV/
# qxD/a//qTkI2rbieibOJSAAAF3NhbW15a2VycmlkZ2VAZ21haWwuY29tAQIDBAUG
# -----END OPENSSH PRIVATE KEY-----
# EOM

# KET="-----BEGIN OPENSSH PRIVATE KEY----- b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW QyNTUxOQAAACAi+xonjkSeRKHJjeZueY8LS+mkXUlYJWszCoOuHbBFvgAAAKCYpAGfmKQB nwAAAAtzc2gtZWQyNTUxOQAAACAi+xonjkSeRKHJjeZueY8LS+mkXUlYJWszCoOuHbBFvg AAAEDn+spixd8OLvi/Ny9c0BV0ixKgqWpmBnjTmAc/sK1sciL7GieORJ5EocmN5m55jwtL 6aRdSVglazMKg64dsEW+AAAAF3NhbW15a2VycmlkZ2VAZ21haWwuY29tAQIDBAUG -----END OPENSSH PRIVATE KEY-----"

# MULTILINE_KEY=$(echo $KET | sed \
#     -e "s/-----BEGIN OPENSSH PRIVATE KEY-----/&\n/"\
#     -e "s/-----END OPENSSH PRIVATE KEY-----/\n&/"\
    # -e "s/\S\{70\}/&\n/g")

# echo "$MULTILINE_KEY"
echo "YOOOOOOOOO"

# # Returns a UUID for the Vultr resource requested
# # $1: The type of resource (e.g. 'instance')
# function getResourceID() {
#     vultr-cli $1 list | eval "awk '/django/ {print \$1}'"
# }

# ID=$(getResourceID "instance")