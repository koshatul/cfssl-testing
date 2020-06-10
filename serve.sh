#!/bin/bash

cfssl serve \
 -ca=artifacts/certs/ca.pem \
 -ca-key=artifacts/certs/ca-key.pem \
 -db-config=db-pg.json \
 -loglevel=0
