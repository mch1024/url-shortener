#!/bin/bash

dir=$(dirname $0)
source $dir/vars.sh

set -uxeo pipefail
sudo docker build -t $DOCKER_REPOSITORY .
#sudo docker push $DOCKER_REPOSITORY
