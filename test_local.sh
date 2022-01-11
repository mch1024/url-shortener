#!/bin/bash

set -uxe

set +x
curl http://127.0.0.1:3000/api/v1/lookup/12345678901
echo
echo
curl --fail -X POST -d '' http://127.0.0.1:3000/api/v1/shorten/https://www.google.com/
echo
echo
curl --fail http://127.0.0.1:3000/api/v1/lookup/11J3zf_
echo
echo
curl -v --fail http://127.0.0.1:3000/11J3zf_
