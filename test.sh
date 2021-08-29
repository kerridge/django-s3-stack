# !/bin/bash

if [ ! -z "$(vultr-cli instance list | grep django)" ]
then
    vultr-cli instance list
fi