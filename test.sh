#!/bin/bash

# Returns a UUID for the Vultr resource requested
# $1: The type of resource (e.g. 'instance')
function getResourceID() {
    vultr-cli $1 list | eval "awk '/django/ {print \$1}'"
}

ID=$(getResourceID "instance")
