#!/bin/bash

set -uxe
rm -f *.pyc
#FLASK_ENV=development DEBUG=1
REDIS_HOST=172.19.0.2 REDIS_PORT=6379 REDIS_HOST_RO=172.19.0.2 REDIS_PORT_RO=6379 ENV=alpha FLASK_APP=$(dirname $0)/api.py flask run --port 3000
