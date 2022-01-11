#!/bin/bash

set -uxe

set +x
curl http://172.19.0.3/api/v1/lookup/12345678901
echo
echo
curl --fail -X POST -d '' http://172.19.0.3/api/v1/shorten/https://www.google.com/
echo
echo
curl --fail http://172.19.0.3/api/v1/lookup/11J3zf_
echo
echo
curl -v --fail http://172.19.0.3/11J3zf_
