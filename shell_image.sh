#!/bin/bash

dir=$(dirname $0)
source $dir/vars.sh

set -uxeo pipefail
sudo docker run --rm -it --entrypoint sh $DOCKER_REPOSITORY
