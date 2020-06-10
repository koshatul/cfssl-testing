#!/bin/bash

curl \
 -sSL \
 -X POST \
 -H "Content-Type: application/json" \
 -d @test-client.json \
 http://127.0.0.1:8888/api/v1/cfssl/newcert | jq .
