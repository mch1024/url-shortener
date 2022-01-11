#!/bin/sh

set -uxe

gunicorn -w 4 -b 127.0.0.1:3000 api:app &
nginx -g "daemon off;"
