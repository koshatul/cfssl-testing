#!/bin/bash

curl \
 -sSL \
 http://127.0.0.1:8888/api/v1/cfssl/info | jq .
