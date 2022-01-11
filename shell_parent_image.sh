#!/bin/bash

set -uxeo pipefail

image=$(egrep '^FROM' Dockerfile | awk '{ print $2 }')
sudo docker run --rm -it --entrypoint sh $image
