#!/bin/bash

jq -r .result.certificate | tee tmp-user.pem
