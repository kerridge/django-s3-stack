# !/bin/bash

# GITHUB_REPOSITORY_CLONE_URL=$1
# GITHUB_REPOSITORY_NAME=$2
# GITHUB_USERNAME=$3
# GITHUB_ACCESS_TOKEN=$4

# Change working directory
ROOT_DIR="/home/docker/"
WORK_DIR=$ROOT_DIR/$GITHUB_REPOSITORY_NAME

cd $ROOT_DIR

# If repository doesn't exist on server
if [[ ! -d $GITHUB_REPOSITORY_NAME ]]; then
    # git config --global credential.helper 'cache --timeout=10800'
    
    # # Login to Github using github access token?
    # git config --user.name=$GITHUB_USERNAME

    # Clone repository
    # git clone $GITHUB_REPOSITORY_CLONE_URL 
    git clone https://$GITHUB_ACCESS_TOKEN:x-oauth-basic@github.com/$GITHUB_USERNAME/$GITHUB_REPOSITORY_NAME.git
fi 

cd $GITHUB_REPOSITORY_NAME

# Pull latest repo changes in case our scripts updated
git pull origin vultr

# # Stop currently running containers
# ./docker-tasks.sh --prod stop

# # Start and Pull new containers
# ./docker-tasks.sh --prod run

# # Health check new containers
#     # if healthy
#     exit 0

#     # elif unhealthy
#     exit 1